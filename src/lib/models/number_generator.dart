import "dart:math";

import "package:numly/models/random.dart";
import "package:numly/models/rational_number.dart";

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
    required this.minimum,
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
    required this.numeratorMinimum,
    required this.numeratorMaximum,
    required this.denominatorMinimum,
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
