import "dart:math";

import "package:numly/models/random.dart";

class Number {
  final double value;

  late final isNegative = value < 0;
  late final isDecimal = value % 1 != 0;

  Number({required this.value});

  @override
  String toString() {
    if (isDecimal) {
      return value.toString();
    } else {
      return value.toInt().toString();
    }
  }
}

abstract class NumberGenerator {
  Number generate();
}

class ConstantNumberGenerator implements NumberGenerator {
  final double value;

  ConstantNumberGenerator({
    required this.value,
  });

  @override
  Number generate() {
    return Number(value: value);
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
  Number generate() {
    final range = maximum - minimum;
    final intPart = minimum + random.nextInt(range);

    var value = intPart.toDouble();

    if (decimals != 0) {
      final scale = pow(10, decimals).toInt();
      final decimalPart = 1 + random.nextInt(scale - 1);
      value += decimalPart / scale;
      value = double.parse(value.toStringAsFixed(decimals));
    }

    return Number(value: value);
  }
}
