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

  bool validsign(int x) {
    if (x >> 31 == 1) {
      return false;
    }
    return true;
  }
  // logarithm base 2 for MSb calculation
double logBase(num x, num base) => log(x) / log(base);
double log2(num x) => logBase(x, 2);
int mySqrt(int N)
{
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

  double solve(String formula) {
// uses quadratic formula
    double posroot;
    double negroot;
    int a = 0, b = 0, c = 0;
    bool iscomplex;
// first, check for a, b , and c in polynomial. If one doesnt exist, use 0
    posroot = -b + sqrt(pow(b, 2) - 4 * a * c) / 2 * a;
    negroot = -b - sqrt(pow(b, 2) - 4 * a * c) / 2 * a;
// check if root is complex

    if (posroot.isNegative) {
      print('ROOT FAIL');
    } else {
      return posroot;
    }
    return 0x0;
  }

// symbols
//π
//ⁿ
//√
//
  int parsehelper(String polynomial) {
// find dart library for parsing these strings

    return 0x0;
  }
}
