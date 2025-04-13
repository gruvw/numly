import "package:numly/models/rational_number.dart";

enum Operation {
  addition,
  subtraction,
  multiplication,
  division,
  power,
  root;

  RationalNumber compute(RationalNumber number1, RationalNumber number2) {
    switch (this) {
      case addition:
        return number1.add(number2);
      case subtraction:
        return number1.sub(number2);
      case multiplication:
        return number1.mul(number2);
      case division:
        return number1.div(number2);
      case power:
        return number1.pow(number2);
      case root:
        return number1.nrt(number2);
    }
  }
}
