





Float
Sqrt(Float x)
{
    using F = decltype(x);
    if (x == 0 || x == INFINITY || isnan(x))
        return x;
    if (x < 0)
        return F{NAN};
    int e;
    x = std::frexp(x, &e);
    if (e % 2 != 0)
    {
        ++e;
        x /= 2;
    }
    auto y = (F{-160}/567*x + F{2'848}/2'835)*x + F{155}/567;
    y = (y + x/y)/2;
    y = (y + x/y)/2;
    return std::ldexp(y, e/2);
}
