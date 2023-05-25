
import 'dart:math';

// class used for more complex operations not supported by the dart library
class Helper {
  Helper();

  int mySquare(int n) {
    int i = n;
    int sq = 0;
    int count = 0;

    while (i > 0) {
      if ((i & 1) == 1) {
        sq += n << count;
      }
      i = i >> 1;
      count++;
    }

    return sq;
  }

  bool isOperator(String x) {
    if (x == '÷' ||
        x == '*' ||
        x == 'sqrt' ||
        x == '-' ||
        x == 'x' ||
        x == '+' ||
        x == '=' ||
        x == 'alt' ||
        x == 'cos' ||
        x == 'sin' ||
        x == 'tan' ||
        x == 'log' ||
        x == '!') {
      return true;
    } else {
      return false;
    }
  }

  bool isNumber(String x) {
    for (int i = 0; i <= 9; i++) {
      if (x[0] == i.toString() || x[0] == '.') {
        return true;
      }
    }
    return false;
  }

  bool validsign(int x) {
     // for integers that dont necesarilly behave well with factorials
    if (x >> 31 == 1) {
      return false;
    }
    return true;
  }

  // logarithm base 2 for MSb calculation
  double log2(num x) => logBase(x, 2);
  // log base 2 calc
  double logBase(num x, num base) => log(x) / log(base);
// square root function bitwise
  int mySqrt(int N) {
    // Find MSB(Most significant Bit) of N
    int msb = (log2(N)).round();

    // (a = 2^msb)
    int a = 1 << msb;
    int result = 0;
    while (a != 0) {
      // Check whether the current value
      // of 'a' can be added or not
      if ((result + a) * (result + a) <= N) {
        result += a;
      }

      // (a = a/2)
      a >>= 1;
    }

    // Return the result
    return result;
  }
  // port this algorithm from c++
  /* 
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
*/
// symbols
//π
//ⁿ
//√
//
  int parsehelper(String input) {
// find dart library for parsing these polynomial strings
   
    return 0x0;
  }
}
