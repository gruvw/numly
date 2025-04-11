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
    final range = maximum - minimum;
    final intPart = minimum + random.nextInt(range);

    var number = intPart.toString();

    if (decimals != 0) {
      final scale = pow(10, decimals).toInt();
      final decimalPart = 1 + random.nextInt(scale - 1);
      number += ".$decimalPart";
    }

    return RationalNumber.parse(number);
  }
}
