// PROBE 1: multi-word struct passed AND returned by value
struct Vec2 { float x, y; };

Vec2 Add( Vec2 a, Vec2 b )
{
    Vec2 r;
    r.x = a.x + b.x;
    r.y = a.y + b.y;
    return r;
}

void main()
{
    Vec2 p; p.x = 1.0; p.y = 2.0;
    Vec2 q; q.x = 3.0; q.y = 4.0;
    Vec2 s = Add( p, q );
}
