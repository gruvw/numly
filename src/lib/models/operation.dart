import "package:numly/models/rational_number.dart";

enum Operation {
  addition,
  subtraction,
  multiplication,
  division;
  // power,
  // root,

  RationalNumber compute(RationalNumber number1, RationalNumber number2) {
    switch (this) {
      case addition:
        return RationalNumber(value: number1.value + number2.value);
      case subtraction:
        return RationalNumber(value: number1.value - number2.value);
      case multiplication:
        return RationalNumber(value: number1.value * number2.value);
      case division:
        return RationalNumber(value: number1.value / number2.value);
    }
  }
}
