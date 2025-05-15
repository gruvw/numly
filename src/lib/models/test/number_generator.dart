import "dart:math";

import "package:numly/models/math/random.dart";
import "package:numly/models/math/rational_number.dart";

abstract class NumberGenerator {
  RationalNumber generate();
}

class ConstantNumberGenerator implements NumberGenerator {
  final RationalNumber number;

  ConstantNumberGenerator({
    required this.number,
  });

  @override
  RationalNumber generate() {
    return number;
  }
}

class MinMaxDecimalNumberGenerator implements NumberGenerator {
  /// Minimum number value (inclusive)
  final int minimum;

  /// Maximum number value (exclusive)
  final int maximum;

  /// Number of decimals
  /// If non-zero, the number will always have a (non-zero) decimal part.
  final int decimals;

  MinMaxDecimalNumberGenerator({
    this.minimum = 0,
    required this.maximum,
    required this.decimals,
  })  : assert(
          minimum <= maximum,
          "`minimum` should be smaller than or equal to `maximum`.",
        ),
        assert(
          decimals >= 0,
          "`decimals` should be positive or zero.",
        );

  @override
  RationalNumber generate() {
    final intPart = randomIntRange(minimum, maximum);

    var number = intPart.toString();

    if (decimals != 0) {
      final scale = pow(10, decimals).toInt();
      final decimalPart = randomIntRange(1, scale - 1);
      number += ".$decimalPart";
    }

    return RationalNumber.parse(number);
  }
}

class MinMaxIntegerNumberGenerator extends MinMaxDecimalNumberGenerator {
  MinMaxIntegerNumberGenerator({
    super.minimum,
    required super.maximum,
  }) : super(decimals: 0);
}

class MinMaxFractionalNumberGenerator implements NumberGenerator {
  /// Minimum number value (inclusive)
  final int numeratorMinimum;

  /// Maximum number value (exclusive)
  final int numeratorMaximum;

  /// Minimum number value (inclusive)
  final int denominatorMinimum;

  /// Maximum number value (exclusive)
  final int denominatorMaximum;

  MinMaxFractionalNumberGenerator({
    this.numeratorMinimum = 0,
    required this.numeratorMaximum,
    this.denominatorMinimum = 0,
    required this.denominatorMaximum,
  })  : assert(
          numeratorMinimum <= numeratorMaximum,
          "`numeratorMinimum` should be smaller than or equal to `numeratorMaximum`.",
        ),
        assert(
          denominatorMinimum <= denominatorMaximum,
          "`denominatorMinimum` should be smaller than or equal to `denominatorMaximum`.",
        );

  @override
  RationalNumber generate() {
    final numerator = randomIntRange(numeratorMinimum, numeratorMaximum);

    int denominator;
    if (denominatorMinimum <= 0 && 0 <= denominatorMaximum) {
      // zero is within the range, so we skip it
      denominator = randomIntRange(denominatorMinimum, denominatorMaximum - 1);
      if (denominator >= 0) {
        denominator++;
      }
    } else {
      // zero is not in the range, no division by 0
      denominator = randomIntRange(denominatorMinimum, denominatorMaximum);
    }

    return RationalNumber.fromInt(
      numerator,
      denominator,
    );
  }
}

class SimplePercentNumberGenerator extends MinMaxFractionalNumberGenerator {
  SimplePercentNumberGenerator({
    super.numeratorMinimum,
    required super.numeratorMaximum,
  }) : super(denominatorMinimum: 100, denominatorMaximum: 100);
}
