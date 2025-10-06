import "package:numly/models/math/rational_number.dart";

enum Operation {
  addition,
  subtraction,
  multiplication,
  division,
  power,
  root;

  RationalNumber compute(RationalNumber number1, RationalNumber number2) {
    return switch (this) {
      addition => number1.add(number2),
      subtraction => number1.sub(number2),
      multiplication => number1.mul(number2),
      division => number1.div(number2),
      power => number1.pow(number2),
      root => number1.nrt(number2),
    };
  }
}
