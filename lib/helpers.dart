import 'dart:math';

// homebrew library used for calculator fuctions and extensions not supported by dart 

class Point{
   double x=0.0;
   double y=0.0;

   Point(this.x,this.y);

   static double Distance(Point a, Point b){
    Helper h =Helper(); 
    double dx = a.x - b.x ;
    double dy = a.y - b.y ;
      return (h.mySqrt(dx*dx+dy*dy));
    }

  }

class Graph{
  var points= <Point>{};
  Graph(this.points);

}

  

class Helper {
  Helper();


 
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

  bool isNumber(String x, int index) {
    for (int i = 0; i <= 9; i++) {
      if (x[index] == i.toString() || x[index] == '.') {
        return true;
      }
    }
    return false;
  }

  double myFactorial( double x){
      if(x==0 || x==1){
         return x;
        }
        else{
           return x*myFactorial(x-1);
          }
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
  double mySqrt(double N) {
    // Find MSB(Most significant Bit) of N
    int msb = (log2(N)).round();

    // (a = 2^msb)
    int a = 1 << msb;
    double result = 0;
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

 double myPow(double x,double n){
  if(n==0){
      return 1;
    }
    for(int i=0;i<n;i++){
        x*=myPow(x,i-1);
      }
      return x;
  }
double myEulers(double X){
// sim of e^x = x^n / n! 
  double sum =0;
  for(double i=0.0;i<10.0;i++){
       sum+= myPow(X,i)/myFactorial(i);
    }
   return sum;
  }
double mySin(double N){
//sin simulation using to calculate value  
  
   return 1.0; 
  }

  double myCos(double N){


return 1.0;
    }

  double myTan(double N){
      return (mySin(N)/myCos(N));
    }

  double myArcSin(double N){



return 1.0;
 } 
  double myArcCos(double N){


return 1.0;
    }

  double myArcTan(double N){
    return myArcSin(N)/myArcCos(N);

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


