// =============================================================================
//   ASTEROIDS B2 -- the Box2D-augmented Asteroids for Vircon32
// =============================================================================
//   The classic AsteroidsV32 gameplay, rebuilt on the VirconBox2D physics
//   engine through the vb2 facade. What physics buys over the original:
//
//     * Asteroids are REAL polygon bodies: they spin, and they bounce off
//       EACH OTHER (in the original they fly through one another).
//     * Bullets are physical bullet-flagged bodies with continuous collision,
//       so a fast shot cannot tunnel through a small rock -- and every hit
//       transfers real momentum before the rock splits.
//     * The ship is a dynamic body: ramming an asteroid shoves both, and
//       during the respawn shield you can physically bounce rocks away.
//     * Collision detection is the engine's begin-touch events -- no hand-
//       rolled radius checks anywhere.
//
//   Controls: d-pad left/right = rotate, A = thrust, B = fire.
//   Build:  bash build.sh asteroidsb2   ->  bin/asteroidsb2.v32
// =============================================================================

#include "video.h"
#include "math.h"
#include "time.h"
#include "input.h"
#include "misc.h"
#include "audio.h"
#include "draw_primitives.h"
#include "vb2.h"

// world: camera default is 20 px/m centered at the origin, so the 640x360
// screen shows exactly 32 x 18 meters
#define WORLD_HALF_W 16.0
#define WORLD_HALF_H 9.0
#define WRAP_MARGIN 1.5        // bodies wrap this far past the screen edge
#define PX_TO_M 0.05           // the classic shape tables are in pixels

// sounds (index = order in the XML <sounds> list)
#define SND_SHOOT   0
#define SND_EXPLODE 1
#define SND_SHIPHIT 2
#define SND_THRUST  3
#define CH_THRUST   15

#define SHIP_RADIUS 0.5

int score = 0;
int maxScore = 0;
int lives = 3;
bool isAlive = true;
int[12] numberBuffer;

// -----------------------------------------------------------------------------
//   Asteroid + bullet pools (handles into the physics world)
// -----------------------------------------------------------------------------

// same 5 classic shapes: 0,1 = big (~20 px), 2,3 = medium (~12 px), 4 = small
int[5][6][2] asteroidShapes = {
    {{-20, 0}, {-10, 20}, {10, 20}, {20, 0}, {10, -20}, {-10, -20}}, // Hexagonal
    {{-20, 10}, {0, 20}, {10, 0}, {20, 0}, {0, -20}, {-10, -20}},    // Hex with cutout
    {{-9, 9}, {0, 6}, {9, 9}, {6, -6}, {0, -3}, {-6, -6}},           // Tie like
    {{0, 9}, {6, 3}, {12, 6}, {0, -6}, {-12, 6}, {-6, 3}},           // Lotus kinda
    {{-10, 0}, {-5, 10}, {5, 10}, {10, 0}, {5, -10}, {-5, -10}}      // Small hex
};

#define MAX_ASTEROIDS 36
#define MAX_CONCURRENT_BIG 5

struct AsteroidB2
{
    int handle;      // vb2 body handle
    int size;        // 2 = big, 1 = medium, 0 = small
    int shapeType;
    bool active;
};

AsteroidB2[MAX_ASTEROIDS] asteroids;

#define MAX_BULLETS 12
#define BULLET_SPEED 14.0
#define BULLET_LIFE 70

struct BulletB2
{
    int handle;
    int life;        // frames left
    bool active;
};

BulletB2[MAX_BULLETS] bullets;

int shipHandle = -1;
float shipAngle = 0.0;
int invulnFrames = 0;       // respawn shield: no damage while > 0

int spawnTimer = 0;
#define SPAWN_INTERVAL 300  // one new big rock every ~5 seconds

// per-frame event marks
bool[MAX_ASTEROIDS] asteroidDead;
bool[MAX_ASTEROIDS] asteroidScored;
bool[MAX_BULLETS] bulletSpent;


int asteroid_points(int size)
{
    if (size == 2) return 20;
    if (size == 1) return 50;
    return 100;
}

float frand(float lo, float hi)
{
    return lo + (rand() % 1000) / 999.0 * (hi - lo);
}

void int_to_string(int value, int* buffer)
{
    if (value == 0)
    {
        buffer[0] = '0';
        buffer[1] = 0;
        return;
    }

    int isNegative = 0;
    if (value < 0)
    {
        isNegative = 1;
        value = -value;
    }

    int[10] digits;
    int length = 0;

    while (value > 0)
    {
        digits[length++] = '0' + (value % 10);
        value /= 10;
    }

    int i = 0;
    if (isNegative)
        buffer[i++] = '-';

    for (int j = length - 1; j >= 0; j--)
        buffer[i++] = digits[j];

    buffer[i] = 0;
}

// -----------------------------------------------------------------------------
//   Body creation (raw b2 API where the facade has no polygon creator;
//   returns a facade handle exactly like vb2_Box does)
// -----------------------------------------------------------------------------

int make_asteroid_body(float x, float y, float vx, float vy, float angVel, int shapeType)
{
    b2BodyDef bd;  b2DefaultBodyDef(&bd);
    bd.type = b2_dynamicBody;
    bd.position.x = x;
    bd.position.y = y;

    b2BodyId id;  b2CreateBody(&vb2_world, &bd, &id);

    // classic pixel table -> convex hull in meters
    b2Vec2[6] pts;
    for (int j = 0; j < 6; j++)
    {
        pts[j].x = asteroidShapes[shapeType][j][0] * PX_TO_M;
        pts[j].y = asteroidShapes[shapeType][j][1] * PX_TO_M;
    }

    b2Hull hull;     b2ComputeHull(pts, 6, &hull);
    b2Polygon poly;  b2MakePolygon(&hull, 0.0, &poly);

    b2ShapeDef sd;  b2DefaultShapeDef(&sd);
    sd.density = 2.0;
    sd.friction = 0.3;       // contact friction makes colliding rocks spin
    sd.restitution = 0.7;    // lively rock-on-rock bounces

    b2ShapeId sh;  b2CreatePolygonShape(&vb2_world, &id, &sd, &poly, &sh);

    int handle = vb2_PackHandle(id.index1, id.generation);
    vb2_SetVelocity(handle, vx, vy);
    vb2_SetAngularVelocity(handle, angVel);
    return handle;
}

// finds a free pool slot; returns the pool index or -1
int spawn_asteroid(float x, float y, float vx, float vy, int size)
{
    for (int i = 0; i < MAX_ASTEROIDS; i++)
    {
        if (!asteroids[i].active)
        {
            int shapeType;
            if (size == 2)
                shapeType = rand() % 2;
            else if (size == 1)
                shapeType = 2 + (rand() % 2);
            else
                shapeType = 4;

            float angVel = frand(-1.5, 1.5);

            asteroids[i].handle = make_asteroid_body(x, y, vx, vy, angVel, shapeType);
            asteroids[i].size = size;
            asteroids[i].shapeType = shapeType;
            asteroids[i].active = true;
            return i;
        }
    }
    return -1;
}

// destroy an asteroid's body; big/medium split into two smaller rocks that
// inherit the parent's velocity plus an opposite separation kick
void split_asteroid(int index)
{
    AsteroidB2* a = &asteroids[index];
    if (!a->active) return;

    float px = vb2_GetX(a->handle);
    float py = vb2_GetY(a->handle);
    float pvx = vb2_GetVX(a->handle);
    float pvy = vb2_GetVY(a->handle);
    int size = a->size;

    vb2_Destroy(a->handle);
    a->active = false;

    if (size > 0)
    {
        float ang = frand(0.0, 2.0 * pi);
        float dx = cos(ang);
        float dy = sin(ang);

        spawn_asteroid(px + dx * 0.4, py + dy * 0.4, pvx + dx * 1.4, pvy + dy * 1.4, size - 1);
        spawn_asteroid(px - dx * 0.4, py - dy * 0.4, pvx - dx * 1.4, pvy - dy * 1.4, size - 1);
    }
}

int count_active_asteroids()
{
    int count = 0;
    for (int i = 0; i < MAX_ASTEROIDS; i++)
        if (asteroids[i].active) count++;
    return count;
}

int count_active_big()
{
    int count = 0;
    for (int i = 0; i < MAX_ASTEROIDS; i++)
        if (asteroids[i].active && asteroids[i].size == 2) count++;
    return count;
}

// a new big rock drifts in from just outside a random screen edge
void spawn_big_offscreen()
{
    if (count_active_big() >= MAX_CONCURRENT_BIG) return;

    int edge = rand() % 4;
    float x, y, vx, vy;
    float speed = frand(0.8, 1.8);

    if (edge == 0) {            // top
        x = frand(-WORLD_HALF_W, WORLD_HALF_W);
        y = WORLD_HALF_H + 1.2;
        vx = frand(-0.9, 0.9);
        vy = -speed;
    } else if (edge == 1) {     // bottom
        x = frand(-WORLD_HALF_W, WORLD_HALF_W);
        y = -WORLD_HALF_H - 1.2;
        vx = frand(-0.9, 0.9);
        vy = speed;
    } else if (edge == 2) {     // left
        x = -WORLD_HALF_W - 1.2;
        y = frand(-WORLD_HALF_H, WORLD_HALF_H);
        vx = speed;
        vy = frand(-0.9, 0.9);
    } else {                    // right
        x = WORLD_HALF_W + 1.2;
        y = frand(-WORLD_HALF_H, WORLD_HALF_H);
        vx = -speed;
        vy = frand(-0.9, 0.9);
    }

    spawn_asteroid(x, y, vx, vy, 2);
}

// the starting field: big rocks away from the ship at the origin
void spawn_initial_field()
{
    for (int n = 0; n < 4; n++)
    {
        float x, y;
        int attempts = 0;
        do {
            x = frand(-WORLD_HALF_W + 1.0, WORLD_HALF_W - 1.0);
            y = frand(-WORLD_HALF_H + 1.0, WORLD_HALF_H - 1.0);
            attempts++;
        } while (x * x + y * y < 30.0 && attempts < 100);   // keep >~5.5 m from the ship

        spawn_asteroid(x, y, frand(-1.5, 1.5), frand(-1.5, 1.5), 2);
    }
}

int find_asteroid(int handle)
{
    if (handle == -1) return -1;
    for (int i = 0; i < MAX_ASTEROIDS; i++)
        if (asteroids[i].active && asteroids[i].handle == handle) return i;
    return -1;
}

int find_bullet(int handle)
{
    if (handle == -1) return -1;
    for (int i = 0; i < MAX_BULLETS; i++)
        if (bullets[i].active && bullets[i].handle == handle) return i;
    return -1;
}

// -----------------------------------------------------------------------------
//   Bullets
// -----------------------------------------------------------------------------

void fire_bullet()
{
    for (int i = 0; i < MAX_BULLETS; i++)
    {
        if (!bullets[i].active)
        {
            float dx = cos(shipAngle);
            float dy = sin(shipAngle);
            float sx = vb2_GetX(shipHandle);
            float sy = vb2_GetY(shipHandle);

            b2BodyDef bd;  b2DefaultBodyDef(&bd);
            bd.type = b2_dynamicBody;
            bd.isBullet = true;                    // continuous collision: no tunneling
            bd.position.x = sx + dx * (SHIP_RADIUS + 0.3);
            bd.position.y = sy + dy * (SHIP_RADIUS + 0.3);

            b2BodyId id;  b2CreateBody(&vb2_world, &bd, &id);

            b2Circle circle;
            circle.center.x = 0.0;
            circle.center.y = 0.0;
            circle.radius = 0.12;

            b2ShapeDef sd;  b2DefaultShapeDef(&sd);
            sd.density = 4.0;                      // heavy enough to visibly shove a rock

            b2ShapeId sh;  b2CreateCircleShape(&vb2_world, &id, &sd, &circle, &sh);

            bullets[i].handle = vb2_PackHandle(id.index1, id.generation);
            bullets[i].life = BULLET_LIFE;
            bullets[i].active = true;

            // bullets inherit the ship's velocity, like the real thing
            vb2_SetVelocity(bullets[i].handle,
                            vb2_GetVX(shipHandle) + dx * BULLET_SPEED,
                            vb2_GetVY(shipHandle) + dy * BULLET_SPEED);

            play_sound(SND_SHOOT);
            break;
        }
    }
}

void destroy_bullet(int i)
{
    if (!bullets[i].active) return;
    vb2_Destroy(bullets[i].handle);
    bullets[i].active = false;
}

// -----------------------------------------------------------------------------
//   Screen wrap (physics version: teleport the body across the world)
// -----------------------------------------------------------------------------

void wrap_body(int handle)
{
    float x = vb2_GetX(handle);
    float y = vb2_GetY(handle);
    float nx = x;
    float ny = y;

    if (x < -WORLD_HALF_W - WRAP_MARGIN) nx = x + 2.0 * (WORLD_HALF_W + WRAP_MARGIN);
    if (x >  WORLD_HALF_W + WRAP_MARGIN) nx = x - 2.0 * (WORLD_HALF_W + WRAP_MARGIN);
    if (y < -WORLD_HALF_H - WRAP_MARGIN) ny = y + 2.0 * (WORLD_HALF_H + WRAP_MARGIN);
    if (y >  WORLD_HALF_H + WRAP_MARGIN) ny = y - 2.0 * (WORLD_HALF_H + WRAP_MARGIN);

    if (nx != x || ny != y)
        vb2_SetPosition(handle, nx, ny);
}

// -----------------------------------------------------------------------------
//   Drawing (world meters, y-up  ->  screen pixels through the vb2 camera)
// -----------------------------------------------------------------------------

void draw_asteroid_b2(AsteroidB2* a)
{
    if (!a->active) return;

    float x = vb2_GetX(a->handle);
    float y = vb2_GetY(a->handle);
    float ang = vb2_GetAngle(a->handle);
    float c = cos(ang);
    float s = sin(ang);
    int shapeType = a->shapeType;

    for (int j = 0; j < 6; j++)
    {
        int jn = (j + 1) % 6;

        float lx1 = asteroidShapes[shapeType][j][0] * PX_TO_M;
        float ly1 = asteroidShapes[shapeType][j][1] * PX_TO_M;
        float lx2 = asteroidShapes[shapeType][jn][0] * PX_TO_M;
        float ly2 = asteroidShapes[shapeType][jn][1] * PX_TO_M;

        float wx1 = x + c * lx1 - s * ly1;
        float wy1 = y + s * lx1 + c * ly1;
        float wx2 = x + c * lx2 - s * ly2;
        float wy2 = y + s * lx2 + c * ly2;

        draw_line(vb2_ScreenX(wx1), vb2_ScreenY(wy1), vb2_ScreenX(wx2), vb2_ScreenY(wy2));
    }
}

void draw_ship_world(float x, float y, float angle, bool thrusting, int flameFrame)
{
    float shipLength = 0.75;      // 15 px at 20 px/m
    float wingLength = 0.4;
    float wingAngle = pi / 4;

    float tipX = x + shipLength * cos(angle);
    float tipY = y + shipLength * sin(angle);
    float rearX = x - shipLength * cos(angle);
    float rearY = y - shipLength * sin(angle);

    float leftX = x + wingLength * cos(angle + wingAngle);
    float leftY = y + wingLength * sin(angle + wingAngle);
    float rightX = x + wingLength * cos(angle - wingAngle);
    float rightY = y + wingLength * sin(angle - wingAngle);

    draw_line(vb2_ScreenX(leftX), vb2_ScreenY(leftY), vb2_ScreenX(tipX), vb2_ScreenY(tipY));
    draw_line(vb2_ScreenX(rightX), vb2_ScreenY(rightY), vb2_ScreenX(tipX), vb2_ScreenY(tipY));

    if (thrusting)
    {
        float flameBaseX = rearX - 0.1 * cos(angle);
        float flameBaseY = rearY - 0.1 * sin(angle);

        float flameSpread = pi / 8;
        float flameLength;
        switch (flameFrame)
        {
            case 0: flameLength = 0.25; break;
            case 1: flameLength = 0.40; break;
            case 2: flameLength = 0.30; break;
            case 3: flameLength = 0.45; break;
            default: flameLength = 0.30; break;
        }

        float f1X = flameBaseX - flameLength * cos(angle + flameSpread);
        float f1Y = flameBaseY - flameLength * sin(angle + flameSpread);
        float f2X = flameBaseX - flameLength * cos(angle - flameSpread);
        float f2Y = flameBaseY - flameLength * sin(angle - flameSpread);

        draw_line(vb2_ScreenX(flameBaseX), vb2_ScreenY(flameBaseY), vb2_ScreenX(f1X), vb2_ScreenY(f1Y));
        draw_line(vb2_ScreenX(flameBaseX), vb2_ScreenY(flameBaseY), vb2_ScreenX(f2X), vb2_ScreenY(f2Y));
    }
}

void draw_bullets()
{
    for (int i = 0; i < MAX_BULLETS; i++)
    {
        if (bullets[i].active)
        {
            float x = vb2_GetX(bullets[i].handle);
            float y = vb2_GetY(bullets[i].handle);
            float vx = vb2_GetVX(bullets[i].handle);
            float vy = vb2_GetVY(bullets[i].handle);

            // short tracer against the direction of travel
            draw_line(vb2_ScreenX(x), vb2_ScreenY(y),
                      vb2_ScreenX(x - vx * 0.025), vb2_ScreenY(y - vy * 0.025));
        }
    }
}

// -----------------------------------------------------------------------------
//   Game reset
// -----------------------------------------------------------------------------

void clear_field()
{
    for (int i = 0; i < MAX_ASTEROIDS; i++)
    {
        if (asteroids[i].active)
        {
            vb2_Destroy(asteroids[i].handle);
            asteroids[i].active = false;
        }
    }
    for (int i = 0; i < MAX_BULLETS; i++)
        destroy_bullet(i);
}

void reset_ship()
{
    vb2_SetPosition(shipHandle, 0.0, 0.0);
    vb2_SetVelocity(shipHandle, 0.0, 0.0);
    vb2_SetAngularVelocity(shipHandle, 0.0);
    shipAngle = pi / 2.0;      // pointing up
}


void main( void )
{
    // -------------------------------------------------------------------------
    //   Physics world: space has no gravity; bullets need continuous collision
    // -------------------------------------------------------------------------
    vb2_Init();
    vb2_SetGravity(0.0, 0.0);
    b2World_EnableContinuous(&vb2_world, true);

    // the ship: a dynamic disc; damping recreates the classic 0.985/frame drag
    shipHandle = vb2_Ball(0.0, 0.0, SHIP_RADIUS);
    vb2_SetFriction(shipHandle, 0.2);
    vb2_SetBounce(shipHandle, 0.4);

    b2BodyId shipId;
    vb2_GetBodyId(shipHandle, &shipId);
    b2Body_SetLinearDamping(&vb2_world, &shipId, 0.9);

    shipAngle = pi / 2.0;

    float rotationSpeed = 4.0;    // rad/s
    float thrustForce = 8.0;      // N (ship mass ~0.79 kg -> ~10 m/s^2)
    float deltaT = 1.0 / 60.0;
    bool isThrusting = false;
    bool wasThrusting = false;
    int flameFrameCounter = 0;

    // the thrust rumble loops on its own reserved channel
    select_sound(SND_THRUST);
    set_sound_loop(true);

    select_gamepad(0);

    spawn_initial_field();

    while (true)
    {
        isThrusting = false;

        // ---------------------------------------------------------------------
        //   Input + per-frame game logic (only while alive)
        // ---------------------------------------------------------------------
        if (isAlive)
        {
            if (gamepad_left() > 0)
                shipAngle += rotationSpeed * deltaT;    // world y-up: + = CCW on screen

            if (gamepad_right() > 0)
                shipAngle -= rotationSpeed * deltaT;

            if (gamepad_button_a() > 0)
            {
                vb2_ApplyForce(shipHandle, thrustForce * cos(shipAngle), thrustForce * sin(shipAngle));
                isThrusting = true;
            }

            if (gamepad_button_b() == 1)
                fire_bullet();

            // spawn a new big rock on a timer, or right away if the field is clear
            spawnTimer++;
            if (spawnTimer >= SPAWN_INTERVAL || count_active_asteroids() == 0)
            {
                spawnTimer = 0;
                spawn_big_offscreen();
            }

            if (invulnFrames > 0)
                invulnFrames--;
        }

        // ---------------------------------------------------------------------
        //   Physics step (the world keeps drifting behind the game-over screen)
        // ---------------------------------------------------------------------
        b2World_Step(&vb2_world, deltaT, 2);

        // ---------------------------------------------------------------------
        //   Touch events: collect the pairs first, THEN destroy bodies, so no
        //   handle in the event list is resolved after its body died
        // ---------------------------------------------------------------------
        if (isAlive)
        {
            int[32] pairA;
            int[32] pairB;
            int pairCount = vb2_TouchCount();
            if (pairCount > 32) pairCount = 32;

            for (int e = 0; e < pairCount; e++)
            {
                pairA[e] = vb2_TouchA(e);
                pairB[e] = vb2_TouchB(e);
            }

            for (int i = 0; i < MAX_ASTEROIDS; i++) { asteroidDead[i] = false; asteroidScored[i] = false; }
            for (int i = 0; i < MAX_BULLETS; i++) bulletSpent[i] = false;
            bool shipWasHit = false;

            for (int e = 0; e < pairCount; e++)
            {
                int a = pairA[e];
                int b = pairB[e];

                if (a == shipHandle || b == shipHandle)
                {
                    int other;
                    if (a == shipHandle) other = b;
                    else                 other = a;

                    int ai = find_asteroid(other);
                    if (ai >= 0 && invulnFrames == 0)
                    {
                        shipWasHit = true;
                        asteroidDead[ai] = true;    // the rock that hit us dies too (no score)
                    }
                }
                else
                {
                    int bi = find_bullet(a);
                    int ai = find_asteroid(b);
                    if (bi < 0)
                    {
                        bi = find_bullet(b);
                        ai = find_asteroid(a);
                    }

                    if (bi >= 0 && ai >= 0)
                    {
                        asteroidDead[ai] = true;
                        asteroidScored[ai] = true;
                        bulletSpent[bi] = true;
                    }
                }
            }

            // resolve the marks: bullets die, rocks split, the ship respawns
            for (int i = 0; i < MAX_BULLETS; i++)
                if (bulletSpent[i])
                    destroy_bullet(i);

            for (int i = 0; i < MAX_ASTEROIDS; i++)
            {
                if (asteroidDead[i] && asteroids[i].active)
                {
                    if (asteroidScored[i])
                        score += asteroid_points(asteroids[i].size);

                    play_sound(SND_EXPLODE);
                    split_asteroid(i);
                }
            }

            if (shipWasHit)
            {
                lives--;
                play_sound(SND_SHIPHIT);
                reset_ship();
                invulnFrames = 150;      // 2.5 s shield: blink, take no damage

                if (lives <= 0)
                {
                    isAlive = false;
                    isThrusting = false;
                }
            }
        }

        // ---------------------------------------------------------------------
        //   Housekeeping: bullet lifetime + screen wrap
        // ---------------------------------------------------------------------
        for (int i = 0; i < MAX_BULLETS; i++)
        {
            if (bullets[i].active)
            {
                bullets[i].life--;
                float bx = vb2_GetX(bullets[i].handle);
                float by = vb2_GetY(bullets[i].handle);

                if (bullets[i].life <= 0
                 || bx < -WORLD_HALF_W - 0.5 || bx > WORLD_HALF_W + 0.5
                 || by < -WORLD_HALF_H - 0.5 || by > WORLD_HALF_H + 0.5)
                    destroy_bullet(i);
            }
        }

        wrap_body(shipHandle);
        for (int i = 0; i < MAX_ASTEROIDS; i++)
            if (asteroids[i].active)
                wrap_body(asteroids[i].handle);

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen(color_black);

        for (int i = 0; i < MAX_ASTEROIDS; i++)
            draw_asteroid_b2(&asteroids[i]);

        draw_bullets();

        if (isAlive)
        {
            flameFrameCounter = (flameFrameCounter + 1) % 4;

            // the respawn shield blinks the ship
            bool shipVisible = true;
            if (invulnFrames > 0 && (invulnFrames / 4) % 2 == 0)
                shipVisible = false;

            if (shipVisible)
                draw_ship_world(vb2_GetX(shipHandle), vb2_GetY(shipHandle),
                                shipAngle, isThrusting, flameFrameCounter);

            int_to_string(score, numberBuffer);
            print_at(10, 10, "Score:");
            print_at(70, 10, numberBuffer);

            print_at(10, 30, "Life:");
            for (int i = 0; i < lives; i++)
                print_at(70 + i * 20, 30, "V");
        }
        else
        {
            if (score > maxScore)
                maxScore = score;

            print_at(270, 170, "GAME OVER");

            int_to_string(score, numberBuffer);
            print_at(250, 190, "Final Score:");
            print_at(380, 190, numberBuffer);

            int_to_string(maxScore, numberBuffer);
            print_at(250, 210, "Highscore:");
            print_at(380, 210, numberBuffer);

            print_at(230, 240, "Press A to restart");

            if (gamepad_button_a() == 1)
            {
                score = 0;
                lives = 3;
                isAlive = true;
                spawnTimer = 0;
                invulnFrames = 150;

                clear_field();
                reset_ship();
                spawn_initial_field();
            }
        }

        // thrust rumble: start the loop when thrust begins, stop when it ends
        if (isThrusting && !wasThrusting)
            play_sound_in_channel(SND_THRUST, CH_THRUST);
        if (!isThrusting && wasThrusting)
            stop_channel(CH_THRUST);
        wasThrusting = isThrusting;

        end_frame();
    }
}
