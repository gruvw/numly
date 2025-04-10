import "package:numly/models/number.dart";

enum Operation {
  addition,
  subtraction,
  multiplication,
  division;
  // power,
  // root,

  DecimalNumber compute(DecimalNumber number1, DecimalNumber number2) {
    switch (this) {
      case addition:
        return DecimalNumber(value: number1.value + number2.value);
      case subtraction:
        return DecimalNumber(value: number1.value - number2.value);
      case multiplication:
        return DecimalNumber(value: number1.value * number2.value);
      case division:
        return DecimalNumber(value: number1.value / number2.value);
    }
  }
}
