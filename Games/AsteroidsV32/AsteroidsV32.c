// ---------------------------------------------------------
//   ASTEROIDS for Vircon32
// ---------------------------------------------------------
// include Vircon libraries
#include "video.h"
#include "math.h"
#include "time.h"
#include "input.h"
#include "misc.h"
#include "audio.h"
#include "draw_primitives.h"


#define SCREEN_WIDTH  640
#define SCREEN_HEIGHT 360

// asteroids wrap with a margin so offscreen spawns fly in
// from the intended edge instead of teleporting across
#define WRAP_MARGIN 30

#define SHIP_COLLISION_RADIUS 10
#define BULLET_RADIUS 2
#define MIN_ASTEROID_RESPAWN_DISTANCE_FROM_SHIP 100.0

// sounds (index = order in the XML <sounds> list)
#define SND_SHOOT   0
#define SND_EXPLODE 1
#define SND_SHIPHIT 2
#define SND_THRUST  3
#define CH_THRUST   15   // reserved channel for the looping thrust rumble

// collision radii matched to the drawn shapes
float ASTEROID_RADIUS_BIG = 17.0;    // shapeType 0, 1 (vertices up to +-20)
float ASTEROID_RADIUS_MEDIUM = 11.0; // shapeType 2, 3 (vertices up to +-12)
float ASTEROID_RADIUS_SMALL = 8.0;   // shapeType 4    (vertices up to +-10)

int score = 0;
int maxScore = 0;
int lives = 3;
bool isAlive = true;
int[12] numberBuffer;

struct Ship
{
    float x, y;        // Position
    float angle;       // Direction in radians
    float velocityX;   // Current velocity
    float velocityY;
};

// Structure to hold projectile information
struct Projectile
{
    float x, y;
    float velocityX, velocityY;
    bool active;
};

#define MAX_PROJECTILES 20
Projectile[MAX_PROJECTILES] projectiles;

struct Asteroid
{
    float x, y;                // Position of the asteroid
    float speedX, speedY;      // Speed of the asteroid
    int shapeType;             // Type of the asteroid shape
    bool active;               // Whether the asteroid is active
    int size;
};

#define NUM_ASTEROID_SHAPES 5

// Shape definitions (manual vertices for 5 asteroid shapes)
// 0,1 = big (~20 px), 2,3 = medium (~12 px), 4 = small (~10 px)
int[NUM_ASTEROID_SHAPES][12][2] asteroidShapes = {
    {{-20, 0}, {-10, 20}, {10, 20}, {20, 0}, {10, -20}, {-10, -20}}, // Hexagonal
    {{-20, 10}, {0, 20}, {10, 0}, {20, 0}, {0, -20}, {-10, -20}},    // Hex with cutout
    {{-9, 9}, {0, 6}, {9, 9}, {6, -6}, {0, -3}, {-6, -6}},           // Tie like
    {{0, 9}, {6, 3}, {12, 6}, {0, -6}, {-12, 6}, {-6, 3}},           // Lotus kinda
    {{-10, 0}, {-5, 10}, {5, 10}, {10, 0}, {5, -10}, {-5, -10}}      // Small hex
};

#define MAX_BIG_ASTEROIDS 5
#define MAX_MEDIUM_ASTEROIDS 20
#define MAX_SMALL_ASTEROIDS 40

int bigAsteroidSpawnTimer = 0;
int BIG_ASTEROID_SPAWN_INTERVAL = 300; // Approx. 5 seconds at 60 FPS (300 frames)
int MAX_CONCURRENT_BIG_ASTEROIDS = 5;

Asteroid[MAX_BIG_ASTEROIDS] bigAsteroids;
Asteroid[MAX_MEDIUM_ASTEROIDS] mediumAsteroids;
Asteroid[MAX_SMALL_ASTEROIDS] smallAsteroids;


// score value per asteroid size (classic: small ones are worth more)
int asteroid_points(int size)
{
    if (size == 2) return 20;
    if (size == 1) return 50;
    return 100;
}

void init_asteroid(Asteroid* a, int size)
{
    a->active = true;
    a->size = size;

    if (rand() % 2 == 0)
        a->speedX = (rand() % 3 + 1);
    else
        a->speedX = -(rand() % 3 + 1);

    if (rand() % 2 == 0)
        a->speedY = (rand() % 3 + 1);
    else
        a->speedY = -(rand() % 3 + 1);

    if (a->speedX == 0) a->speedX = 1.0;
    if (a->speedY == 0) a->speedY = 1.0;

    // Set random spawn position, or you can assign it explicitly after init
    a->x = rand() % SCREEN_WIDTH;
    a->y = rand() % SCREEN_HEIGHT;

    // Assign shape based on size
    if (size == 2)  // Big
        a->shapeType = rand() % 2;        // 0 or 1
    else if (size == 1)  // Medium
        a->shapeType = 2 + (rand() % 2);  // 2 or 3
    else  // Small
        a->shapeType = 4;                 // Only one small shape
}

void update_asteroid(Asteroid* a)
{
    if (!a->active) return;

    a->x += a->speedX;
    a->y += a->speedY;

    if (a->x < -WRAP_MARGIN) a->x += SCREEN_WIDTH + 2 * WRAP_MARGIN;
    if (a->x >= SCREEN_WIDTH + WRAP_MARGIN) a->x -= SCREEN_WIDTH + 2 * WRAP_MARGIN;
    if (a->y < -WRAP_MARGIN) a->y += SCREEN_HEIGHT + 2 * WRAP_MARGIN;
    if (a->y >= SCREEN_HEIGHT + WRAP_MARGIN) a->y -= SCREEN_HEIGHT + 2 * WRAP_MARGIN;
}

void draw_asteroid(Asteroid* a)
{
    if (!a->active) return;

    int shapeType = a->shapeType;
    int num_vertices = 6;

    // Draw the lines of the asteroid based on its shape
    for (int j = 0; j < num_vertices; j++) {
        int x1 = a->x + asteroidShapes[shapeType][j][0];
        int y1 = a->y + asteroidShapes[shapeType][j][1];

        // The next vertex index, wrapping around using num_vertices
        int next_vertex_index = (j + 1) % num_vertices;

        int x2 = a->x + asteroidShapes[shapeType][next_vertex_index][0];
        int y2 = a->y + asteroidShapes[shapeType][next_vertex_index][1];

        draw_line(x1, y1, x2, y2);
    }
}

void draw_asteroids()
{
    for (int i = 0; i < MAX_BIG_ASTEROIDS; i++)
        if (bigAsteroids[i].active)
            draw_asteroid(&bigAsteroids[i]);

    for (int i = 0; i < MAX_MEDIUM_ASTEROIDS; i++)
        if (mediumAsteroids[i].active)
            draw_asteroid(&mediumAsteroids[i]);

    for (int i = 0; i < MAX_SMALL_ASTEROIDS; i++)
        if (smallAsteroids[i].active)
            draw_asteroid(&smallAsteroids[i]);
}

int count_active_asteroids()
{
    int count = 0;
    for (int i = 0; i < MAX_BIG_ASTEROIDS; i++)
        if (bigAsteroids[i].active) count++;
    for (int i = 0; i < MAX_MEDIUM_ASTEROIDS; i++)
        if (mediumAsteroids[i].active) count++;
    for (int i = 0; i < MAX_SMALL_ASTEROIDS; i++)
        if (smallAsteroids[i].active) count++;
    return count;
}

// Deactivate an asteroid; big/medium split into two smaller ones
void destroy_asteroid(Asteroid* a)
{
    int currentSize = a->size;

    // Deactivate the original asteroid
    a->active = false;

    // If it's not the smallest size, spawn two smaller ones
    if (currentSize > 0)
    {
        Asteroid* pool = NULL;
        int maxCount = 0;

        if (currentSize == 2) {  // Big -> Medium
            pool = mediumAsteroids;
            maxCount = MAX_MEDIUM_ASTEROIDS;
        } else if (currentSize == 1) {  // Medium -> Small
            pool = smallAsteroids;
            maxCount = MAX_SMALL_ASTEROIDS;
        }

        if (pool != NULL)
        {
            int spawned = 0;
            for (int i = 0; i < maxCount && spawned < 2; i++)
            {
                if (!pool[i].active)
                {
                    init_asteroid(&pool[i], currentSize - 1);
                    pool[i].x = a->x;
                    pool[i].y = a->y;
                    pool[i].speedX = (rand() % 5 - 2);  // -2 to 2
                    pool[i].speedY = (rand() % 5 - 2);
                    // never let a fragment sit still
                    if (pool[i].speedX == 0 && pool[i].speedY == 0)
                    {
                        if (rand() % 2 == 0) pool[i].speedX = 1;
                        else                 pool[i].speedX = -1;
                        if (rand() % 2 == 0) pool[i].speedY = 1;
                        else                 pool[i].speedY = -1;
                    }
                    spawned++;
                }
            }
        }
    }
}

float get_asteroid_collision_radius(Asteroid* asteroid)
{
    if (!asteroid) return 0; // Safety check

    switch (asteroid->shapeType) {
        case 0:
        case 1:
            return ASTEROID_RADIUS_BIG;
        case 2:
        case 3:
            return ASTEROID_RADIUS_MEDIUM;
        case 4:
            return ASTEROID_RADIUS_SMALL;
        default:
            // Fallback if shapeType is unexpected, perhaps based on size
            if (asteroid->size == 2) return ASTEROID_RADIUS_BIG;
            if (asteroid->size == 1) return ASTEROID_RADIUS_MEDIUM;
            return ASTEROID_RADIUS_SMALL;
    }
}

// Function to check if a bullet has collided with an asteroid
bool check_bullet_asteroid_collision(Projectile *bullet, Asteroid *asteroid)
{
    if (!bullet || !asteroid || !bullet->active || !asteroid->active) return false;

    float distanceX = bullet->x - asteroid->x;
    float distanceY = bullet->y - asteroid->y;
    float distanceSquared = distanceX * distanceX + distanceY * distanceY;

    // hit distance depends on the asteroid's size
    float collisionThreshold = get_asteroid_collision_radius(asteroid) + BULLET_RADIUS;
    return distanceSquared < collisionThreshold * collisionThreshold;
}

// Bullet vs asteroid collisions: destroy, split, score
void update_bullets_and_asteroids()
{
    for (int i = 0; i < MAX_PROJECTILES; i++)
    {
        if (projectiles[i].active)
        {
            bool hit = false;

            // Check collision with BIG asteroids
            for (int j = 0; j < MAX_BIG_ASTEROIDS; j++)
            {
                if (bigAsteroids[j].active && check_bullet_asteroid_collision(&projectiles[i], &bigAsteroids[j]))
                {
                    score += asteroid_points(bigAsteroids[j].size);
                    destroy_asteroid(&bigAsteroids[j]);
                    projectiles[i].active = false;
                    play_sound(SND_EXPLODE);
                    hit = true;
                    break;
                }
            }
            if (hit) continue; // Next projectile if this one hit

            // Check collision with MEDIUM asteroids
            for (int j = 0; j < MAX_MEDIUM_ASTEROIDS; j++)
            {
                if (mediumAsteroids[j].active && check_bullet_asteroid_collision(&projectiles[i], &mediumAsteroids[j]))
                {
                    score += asteroid_points(mediumAsteroids[j].size);
                    destroy_asteroid(&mediumAsteroids[j]);
                    projectiles[i].active = false;
                    play_sound(SND_EXPLODE);
                    hit = true;
                    break;
                }
            }
            if (hit) continue;

            // Check collision with SMALL asteroids
            for (int j = 0; j < MAX_SMALL_ASTEROIDS; j++)
            {
                if (smallAsteroids[j].active && check_bullet_asteroid_collision(&projectiles[i], &smallAsteroids[j]))
                {
                    score += asteroid_points(smallAsteroids[j].size);
                    destroy_asteroid(&smallAsteroids[j]);
                    projectiles[i].active = false;
                    play_sound(SND_EXPLODE);
                    break;
                }
            }
        }
    }
}

bool check_ship_asteroid_collision(Ship* ship, Asteroid* asteroid)
{
    if (!ship || !asteroid || !asteroid->active) {
        return false;
    }

    float distanceX = ship->x - asteroid->x;
    float distanceY = ship->y - asteroid->y;
    float distanceSquared = distanceX * distanceX + distanceY * distanceY;

    float current_asteroid_radius = get_asteroid_collision_radius(asteroid);
    float combinedRadii = SHIP_COLLISION_RADIUS + current_asteroid_radius;

    return distanceSquared < combinedRadii * combinedRadii;
}

void relocate_all_active_asteroids_safely(Ship* player_ship)
{
    float ship_cx = player_ship->x;
    float ship_cy = player_ship->y;
    float min_dist_sq = MIN_ASTEROID_RESPAWN_DISTANCE_FROM_SHIP * MIN_ASTEROID_RESPAWN_DISTANCE_FROM_SHIP;
    int attempts;

    for (int i = 0; i < MAX_BIG_ASTEROIDS; i++) {
        if (bigAsteroids[i].active) {
            attempts = 0;
            float new_x, new_y;
            float dist_sq;
            do {
                new_x = rand() % SCREEN_WIDTH;
                new_y = rand() % SCREEN_HEIGHT;
                float dx = new_x - ship_cx;
                float dy = new_y - ship_cy;
                dist_sq = dx * dx + dy * dy;
                attempts++;
            } while (dist_sq < min_dist_sq && attempts < 100); // Max 100 attempts
            bigAsteroids[i].x = new_x;
            bigAsteroids[i].y = new_y;
        }
    }

    // Relocate Medium Asteroids
    for (int i = 0; i < MAX_MEDIUM_ASTEROIDS; i++) {
        if (mediumAsteroids[i].active) {
            attempts = 0;
            float new_x, new_y;
            float dist_sq;
            do {
                new_x = rand() % SCREEN_WIDTH;
                new_y = rand() % SCREEN_HEIGHT;
                float dx = new_x - ship_cx;
                float dy = new_y - ship_cy;
                dist_sq = dx * dx + dy * dy;
                attempts++;
            } while (dist_sq < min_dist_sq && attempts < 100);
            mediumAsteroids[i].x = new_x;
            mediumAsteroids[i].y = new_y;
        }
    }

    // Relocate Small Asteroids
    for (int i = 0; i < MAX_SMALL_ASTEROIDS; i++) {
        if (smallAsteroids[i].active) {
            attempts = 0;
            float new_x, new_y;
            float dist_sq;
            do {
                new_x = rand() % SCREEN_WIDTH;
                new_y = rand() % SCREEN_HEIGHT;
                float dx = new_x - ship_cx;
                float dy = new_y - ship_cy;
                dist_sq = dx * dx + dy * dy;
                attempts++;
            } while (dist_sq < min_dist_sq && attempts < 100);
            smallAsteroids[i].x = new_x;
            smallAsteroids[i].y = new_y;
        }
    }
}

void int_to_string(int value, int* buffer)
{
    // Handle 0 as a special case
    if (value == 0)
    {
        buffer[0] = '0';
        buffer[1] = 0;
        return;
    }

    // Handle negative numbers
    int isNegative = 0;
    if (value < 0)
    {
        isNegative = 1;
        value = -value;
    }

    int[10] digits; // max 10 digits
    int length = 0;

    // Extract digits in reverse order
    while (value > 0)
    {
        digits[length++] = '0' + (value % 10);
        value /= 10;
    }

    int i = 0;

    // Add minus sign if needed
    if (isNegative)
        buffer[i++] = '-';

    // Copy digits in correct order
    for (int j = length - 1; j >= 0; j--)
        buffer[i++] = digits[j];

    buffer[i] = 0; // null terminator
}

float projectileOffset = 20.0;
// Function to fire a projectile
void fire_projectile(float shipX, float shipY, float shipAngle)
{
    // Find the first inactive projectile slot
    for (int i = 0; i < MAX_PROJECTILES; i++)
    {
        if (!projectiles[i].active)
        {
            // Calculate new starting position based on ship's angle and offset
            projectiles[i].x = shipX + projectileOffset * cos(shipAngle);
            projectiles[i].y = shipY + projectileOffset * sin(shipAngle);

            // Initialize the projectile's velocity
            projectiles[i].velocityX = 5.0 * cos(shipAngle);
            projectiles[i].velocityY = 5.0 * sin(shipAngle);
            projectiles[i].active = true;
            play_sound(SND_SHOOT);
            break;
        }
    }
}

// Function to update projectiles (movement and OOB)
void update_projectiles_state()
{
    for (int i = 0; i < MAX_PROJECTILES; i++)
    {
        if (projectiles[i].active)
        {
            projectiles[i].x += projectiles[i].velocityX;
            projectiles[i].y += projectiles[i].velocityY;

            if (projectiles[i].x < 0 || projectiles[i].x >= SCREEN_WIDTH || projectiles[i].y < 0 || projectiles[i].y >= SCREEN_HEIGHT)
            {
                projectiles[i].active = false;
            }
        }
    }
}

void draw_projectiles()
{
    for (int i = 0; i < MAX_PROJECTILES; i++)
    {
        if (projectiles[i].active)
        {
            // Draw the projectile as a short tracer line
            draw_line((int)projectiles[i].x, (int)projectiles[i].y, (int)(projectiles[i].x - projectiles[i].velocityX), (int)(projectiles[i].y - projectiles[i].velocityY));
        }
    }
}

void draw_ship(int centerX, int centerY, float angle, bool thrusting, int flameFrame)
{
    // === Ship settings ===
    int shipLength = 15;
    int shipWingLength = 8;
    float wingAngle = pi / 4;   // 45 degrees

    // === Flame settings ===
    int flameOffset = 2;    // Distance behind the ship's rear for the flame base

    // Tip position (front of ship)
    int tipX = centerX + shipLength * cos(angle);
    int tipY = centerY + shipLength * sin(angle);

    // Rear position (thrust point)
    int rearX = centerX - shipLength * cos(angle);
    int rearY = centerY - shipLength * sin(angle);

    // Wings
    int leftX = centerX + shipWingLength * cos(angle + wingAngle);
    int leftY = centerY + shipWingLength * sin(angle + wingAngle);

    int rightX = centerX + shipWingLength * cos(angle - wingAngle);
    int rightY = centerY + shipWingLength * sin(angle - wingAngle);

    // Draw ship lines
    draw_line(leftX, leftY, tipX, tipY);
    draw_line(rightX, rightY, tipX, tipY);

    // Draw flames if thrusting
    if (thrusting)
    {
        // Flame base sits just behind the ship's rear
        int flameBaseX = rearX - flameOffset * cos(angle);
        int flameBaseY = rearY - flameOffset * sin(angle);

        // Animate flames using flameFrame
        float flameSpread = pi / 8; // ~22 degrees
        int flameLength;

        // Different lengths for flame frames (cycle)
        switch (flameFrame)
        {
            case 0: flameLength = 5; break;
            case 1: flameLength = 8; break;
            case 2: flameLength = 6; break;
            case 3: flameLength = 9; break;
            default: flameLength = 6; break;
        }

        // Flame 1
        int flame1X = flameBaseX - flameLength * cos(angle + flameSpread);
        int flame1Y = flameBaseY - flameLength * sin(angle + flameSpread);

        // Flame 2
        int flame2X = flameBaseX - flameLength * cos(angle - flameSpread);
        int flame2Y = flameBaseY - flameLength * sin(angle - flameSpread);

        draw_line(flameBaseX, flameBaseY, flame1X, flame1Y);
        draw_line(flameBaseX, flameBaseY, flame2X, flame2Y);
    }
}

void spawn_new_big_asteroid_offscreen()
{
    // Count currently active big asteroids
    int activeBigCount = 0;
    for (int i = 0; i < MAX_BIG_ASTEROIDS; i++) {
        if (bigAsteroids[i].active) {
            activeBigCount++;
        }
    }

    if (activeBigCount >= MAX_CONCURRENT_BIG_ASTEROIDS) {
        return; // Don't spawn if too many are already active
    }

    for (int i = 0; i < MAX_BIG_ASTEROIDS; i++) {
        if (!bigAsteroids[i].active) {
            init_asteroid(&bigAsteroids[i], 2); // size 2 = Big

            int edge = rand() % 4; // 0: top, 1: bottom, 2: left, 3: right
            float spawn_x, spawn_y;
            float speed_x, speed_y;
            // Random base speed between 1.0 and 2.0
            float base_speed = 1.0 + (float)(rand() % 101) / 100.0;

            if (edge == 0) { // Top edge
                spawn_x = (float)(rand() % SCREEN_WIDTH);
                spawn_y = -WRAP_MARGIN + 1.0; // Start just above screen
                speed_x = ((float)(rand() % 201) / 100.0 - 1.0) * base_speed * 0.5;
                speed_y = base_speed; // Move downwards
            } else if (edge == 1) { // Bottom edge
                spawn_x = (float)(rand() % SCREEN_WIDTH);
                spawn_y = SCREEN_HEIGHT + WRAP_MARGIN - 1.0; // Start just below screen
                speed_x = ((float)(rand() % 201) / 100.0 - 1.0) * base_speed * 0.5;
                speed_y = -base_speed; // Move upwards
            } else if (edge == 2) { // Left edge
                spawn_x = -WRAP_MARGIN + 1.0; // Start just left of screen
                spawn_y = (float)(rand() % SCREEN_HEIGHT);
                speed_x = base_speed; // Move rightwards
                speed_y = ((float)(rand() % 201) / 100.0 - 1.0) * base_speed * 0.5;
            } else { // Right edge (edge == 3)
                spawn_x = SCREEN_WIDTH + WRAP_MARGIN - 1.0; // Start just right of screen
                spawn_y = (float)(rand() % SCREEN_HEIGHT);
                speed_x = -base_speed; // Move leftwards
                speed_y = ((float)(rand() % 201) / 100.0 - 1.0) * base_speed * 0.5;
            }
            bigAsteroids[i].x = spawn_x;
            bigAsteroids[i].y = spawn_y;
            bigAsteroids[i].speedX = speed_x;
            bigAsteroids[i].speedY = speed_y;

            break; // One asteroid spawned, exit loop
        }
    }
}


void main( void )
{
    score = 0;
    lives = 3;
    isAlive = true;

    Ship playerShip = { SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0.0, 0.0, 0.0 };

    float rotationSpeed = 4.0;  // radians per second
    float thrustPower = 3.0;    // pixels per second square
    float friction = 0.985;     // friction factor
    float deltaT = 1.0/60.0;    // DeltaTime
    bool isThrusting = false;
    bool wasThrusting = false;
    int flameFrameCounter = 0;

    // the thrust rumble loops on its own reserved channel
    select_sound(SND_THRUST);
    set_sound_loop(true);

    select_gamepad(0);

    // Initialize asteroids and ensure they are not on top of player
    for (int i = 0; i < MAX_BIG_ASTEROIDS; i++) {
        init_asteroid(&bigAsteroids[i], 2);
    }
    // Call relocate once at the beginning to ensure initial asteroids are away from player start
    relocate_all_active_asteroids_safely(&playerShip);

    while (true)
    {
        clear_screen(color_black);

        if (isAlive)
        {
            isThrusting = false;

            // Rotate ship
            if (gamepad_left() > 0)
                playerShip.angle -= rotationSpeed * (deltaT);

            if (gamepad_right() > 0)
                playerShip.angle += rotationSpeed * (deltaT);

            // Thrust forward
            if (gamepad_button_a() > 0)
            {
                playerShip.velocityX += thrustPower * cos(playerShip.angle) * (deltaT);
                playerShip.velocityY += thrustPower * sin(playerShip.angle) * (deltaT);
                isThrusting = true;
            }

            // Fire projectile
            if (gamepad_button_b() == 1)
            {
                fire_projectile(playerShip.x, playerShip.y, playerShip.angle);
            }


            // Update position
            playerShip.x += playerShip.velocityX;
            playerShip.y += playerShip.velocityY;

            // Apply friction
            playerShip.velocityX *= friction;
            playerShip.velocityY *= friction;

            // Wrap screen
            if (playerShip.x < 0) playerShip.x += SCREEN_WIDTH;
            if (playerShip.x >= SCREEN_WIDTH) playerShip.x -= SCREEN_WIDTH;
            if (playerShip.y < 0) playerShip.y += SCREEN_HEIGHT;
            if (playerShip.y >= SCREEN_HEIGHT) playerShip.y -= SCREEN_HEIGHT;

            // Spawn a new big asteroid on a timer, or right away if the field is clear
            bigAsteroidSpawnTimer++;
            if (bigAsteroidSpawnTimer >= BIG_ASTEROID_SPAWN_INTERVAL || count_active_asteroids() == 0) {
                bigAsteroidSpawnTimer = 0;
                spawn_new_big_asteroid_offscreen();
            }

            for (int i = 0; i < MAX_BIG_ASTEROIDS; i++) update_asteroid(&bigAsteroids[i]);
            for (int i = 0; i < MAX_MEDIUM_ASTEROIDS; i++) update_asteroid(&mediumAsteroids[i]);
            for (int i = 0; i < MAX_SMALL_ASTEROIDS; i++) update_asteroid(&smallAsteroids[i]);

            update_projectiles_state();

            update_bullets_and_asteroids();

            bool ship_was_hit_this_frame = false;

            for (int i = 0; i < MAX_BIG_ASTEROIDS; i++) {
                if (bigAsteroids[i].active && check_ship_asteroid_collision(&playerShip, &bigAsteroids[i])) {
                    lives--;
                    destroy_asteroid(&bigAsteroids[i]); // Destroy asteroid first
                    ship_was_hit_this_frame = true;
                    break;
                }
            }
            // Check MEDIUM asteroids (only if not hit by a big one)
            if (!ship_was_hit_this_frame) {
                for (int i = 0; i < MAX_MEDIUM_ASTEROIDS; i++) {
                    if (mediumAsteroids[i].active && check_ship_asteroid_collision(&playerShip, &mediumAsteroids[i])) {
                        lives--;
                        destroy_asteroid(&mediumAsteroids[i]);
                        ship_was_hit_this_frame = true;
                        break;
                    }
                }
            }
            // Check SMALL asteroids (only if not hit by big or medium)
            if (!ship_was_hit_this_frame) {
                for (int i = 0; i < MAX_SMALL_ASTEROIDS; i++) {
                    if (smallAsteroids[i].active && check_ship_asteroid_collision(&playerShip, &smallAsteroids[i])) {
                        lives--;
                        destroy_asteroid(&smallAsteroids[i]);
                        ship_was_hit_this_frame = true;
                        break;
                    }
                }
            }

            if (ship_was_hit_this_frame) {
                play_sound(SND_SHIPHIT);

                playerShip.x = SCREEN_WIDTH / 2.0;
                playerShip.y = SCREEN_HEIGHT / 2.0;
                playerShip.velocityX = 0.0;
                playerShip.velocityY = 0.0;
                playerShip.angle = 0.0;

                relocate_all_active_asteroids_safely(&playerShip);

                if (lives <= 0) {
                    isAlive = false;
                    isThrusting = false;
                }
            }

            // Update flame animation
            flameFrameCounter = (flameFrameCounter + 1) % 4;

            draw_asteroids();

            // Draw ship
            draw_ship((int)playerShip.x, (int)playerShip.y, playerShip.angle, isThrusting, flameFrameCounter);

            draw_projectiles();

            int_to_string(score, numberBuffer);

            set_drawing_point(10, 10);
            print("Score:");

            set_drawing_point(70, 10);
            print(numberBuffer);

            set_drawing_point(10, 30);
            print("Life:");

            for (int i = 0; i < lives; i++)
            {
                set_drawing_point(70 + i * 20, 30);
                print("V");
            }
        }
        else
        {
            isThrusting = false;

            if(score > maxScore)
            {
                maxScore = score;
            }

            set_drawing_point(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 - 10);
            print("GAME OVER");

            int_to_string(score, numberBuffer);
            set_drawing_point(SCREEN_WIDTH/2 - 70, SCREEN_HEIGHT/2 + 10);
            print("Final Score:");
            set_drawing_point(SCREEN_WIDTH/2 + 60, SCREEN_HEIGHT/2 + 10);
            print(numberBuffer);

            int_to_string(maxScore, numberBuffer);
            set_drawing_point(SCREEN_WIDTH/2 - 70, SCREEN_HEIGHT/2 + 30);
            print("Highscore:");
            set_drawing_point(SCREEN_WIDTH/2 + 60, SCREEN_HEIGHT/2 + 30);
            print(numberBuffer);

            set_drawing_point(SCREEN_WIDTH/2 - 90, SCREEN_HEIGHT/2 + 60);
            print("Press A to restart");

            if (gamepad_button_a() == 1)
            {
                score = 0;
                lives = 3;
                isAlive = true;
                bigAsteroidSpawnTimer = 0;
                playerShip.x = SCREEN_WIDTH / 2.0;
                playerShip.y = SCREEN_HEIGHT / 2.0;
                playerShip.velocityX = 0.0;
                playerShip.velocityY = 0.0;
                playerShip.angle = 0;

                // Clear all projectiles
                for(int i=0; i<MAX_PROJECTILES; i++) projectiles[i].active = false;

                // Clear all asteroids and re-initialize starting ones
                for(int i=0; i<MAX_BIG_ASTEROIDS; i++) bigAsteroids[i].active = false;
                for(int i=0; i<MAX_MEDIUM_ASTEROIDS; i++) mediumAsteroids[i].active = false;
                for(int i=0; i<MAX_SMALL_ASTEROIDS; i++) smallAsteroids[i].active = false;

                for (int i = 0; i < MAX_BIG_ASTEROIDS; i++) { // Re-initialize big asteroids
                    init_asteroid(&bigAsteroids[i], 2);
                }
                relocate_all_active_asteroids_safely(&playerShip); // Ensure they are away
            }
        }

        // Thrust rumble: start the loop when thrust begins, stop it when it ends
        if (isThrusting && !wasThrusting)
            play_sound_in_channel(SND_THRUST, CH_THRUST);
        if (!isThrusting && wasThrusting)
            stop_channel(CH_THRUST);
        wasThrusting = isThrusting;

        end_frame();
    }
}
