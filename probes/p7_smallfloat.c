void main()
{
    float e = 0.00000011920929;   // ~1.19e-7
    int zero = 0;
    if( e <= 0.0 ) zero = 1 / zero;   // faults ONLY if e parsed as <= 0
}
