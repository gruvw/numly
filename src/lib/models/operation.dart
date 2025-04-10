import "package:numly/models/number.dart";

enum Operation {
  addition,
  subtraction,
  multiplication,
  division;
  // power,
  // root,

  Number compute(Number number1, Number number2) {
    switch (this) {
      case addition:
        return Number(value: number1.value + number2.value);
      case subtraction:
        return Number(value: number1.value - number2.value);
      case multiplication:
        return Number(value: number1.value * number2.value);
      case division:
        return Number(value: number1.value / number2.value);
    }
  }
}
