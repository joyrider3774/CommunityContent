struct V { float x, y; };
typedef V Pos;
const V Zero = { 0.0, 0.0 };
V Identity = { 1.0, 0.0 };
int[ 32 ] Arr;                 // dialect array syntax
struct Proxy { V[ 8 ] points; int count; };   // array member in struct
void main()
{
    float a = 2.0;
    Pos p; p.x = a; p.y = 0.005;
    Pos q = Zero;
    Identity.x = 5.0;
    Proxy pr; pr.count = 3; pr.points[0].x = 1.0;
}
