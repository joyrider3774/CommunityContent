float b2_eps_denom = 8388608.0;   // 2^23, a global so the compiler can't fold
void main()
{
    float eps = 1.0 / b2_eps_denom;   // must emit a RUNTIME fdiv
}
