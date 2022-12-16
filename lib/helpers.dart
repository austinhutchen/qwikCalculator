import 'dart:math';
// class used for more complex operations not supported by the dart library
class Helper {
  Helper();

int mySquare(int x) {
    return x * x;
  }
// use this to find square root
  double mySqrt(double x) {
    // find a way to include decimals in binary search, and convert to integer
    // after. This only works for whole numbers
    double first = 0;
    double last = x;
    double mid;
    double ans = 0;
    while (first <= last) {
      mid = (first + last) / 2.0;
      double sq = mid * mid;
      if (sq == x) {
        return mid;
      }
      // if decimals were to be included, the below would be a function call for secondary binary search through the decimals, instead of mid being assigned to ans
      if (sq < x) {
        ans = mid;
        first = mid + 1;
      } else if (sq > x) {
        last = mid - 1;
      }
    }
    return ans;
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

  int parsehelper(String polynomial) {
// find dart library for parsing these strings

    return 0x0;
  }
}
