import "dart:math";

import "package:numly/models/random.dart";

// https://github.com/dart-lang/sdk/issues/46180
int _gcd(int a, int b) {
  while (b != 0) {
    final t = b;
    b = a % b;
    a = t;
  }
  return a;
}

class RationalNumber {
  static final fractionalPattern = RegExp(r"^(-?\d+)/(\d+)$");
  static final percentPattern = RegExp(r"^(-?\d+)%$");
  static final decimalPattern = RegExp(r"^(-?\d+)(\.(\d+))?$");

  final int numerator;
  final int denominator;

  late final isNegative = numerator < 0;
  late final isInteger = denominator == 1;
  // TODO late final isDecimal = ;
  late final isPercentage = 100 % denominator == 0;

  /// Only use with reduced form, numerator and denominator coprime
  RationalNumber._reduced({
    required this.numerator,
    required this.denominator,
  })  : assert(
          denominator >= 1,
          "denominator ($denominator) must be larger than 1",
        ),
        assert(
          _gcd(numerator.abs(), denominator) == 1,
          "numerator ($numerator) and denominator ($denominator) must be coprime",
        );

  factory RationalNumber(
    int numerator, [
    int? denominator,
  ]) {
    // integer number
    if (denominator == null) {
      return RationalNumber._reduced(numerator: numerator, denominator: 1);
    }

    // division by 0
    if (denominator == 0) {
      throw ArgumentError("zero is not a valid denominator");
    }

    // 0/x = 0
    if (numerator == 0) {
      return RationalNumber._reduced(numerator: 0, denominator: 1);
    }

    // make denominator positive
    if (denominator < 0) {
      numerator = -numerator;
      denominator = -denominator;
    }

    // reduce
    final gcd = _gcd(numerator.abs(), denominator.abs());

    return RationalNumber._reduced(
      numerator: numerator ~/ gcd,
      denominator: denominator ~/ gcd,
    );
  }

  factory RationalNumber.fromString(String text) {
    final fractionalMatch = fractionalPattern.firstMatch(text);
    if (fractionalMatch != null) {
      final numerator = fractionalMatch.group(1)!;
      final denominator = fractionalMatch.group(2)!;
      return RationalNumber(
        int.parse(numerator),
        int.parse(denominator),
      );
    }

    final percentMatch = percentPattern.firstMatch(text);
    if (percentMatch != null) {
      final numerator = percentMatch.group(1)!;
      return RationalNumber(
        int.parse(numerator),
        100,
      );
    }

    final decimalMatch = decimalPattern.firstMatch(text);
    if (decimalMatch != null) {
      final intPart = decimalMatch.group(1)!;
      final decPart = decimalMatch.group(2) ?? "";

      final numerator = intPart + decPart;
      final denominator = pow(10, decPart.length);

      return RationalNumber(
        int.parse(numerator),
        denominator.toInt(),
      );
    }

    throw FormatException("$text is not a valid rational number format");
  }

  @override
  String toString() {
    if (isInteger) {
      return "$numerator";
    } else {
      return "$numerator/$denominator";
    }
  }
}

abstract class NumberGenerator {
  DecimalNumber generate();
}

class ConstantNumberGenerator implements NumberGenerator {
  final double value;

  ConstantNumberGenerator({
    required this.value,
  });

  @override
  DecimalNumber generate() {
    return DecimalNumber(value: value);
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
  DecimalNumber generate() {
    final range = maximum - minimum;
    final intPart = minimum + random.nextInt(range);

    var value = intPart.toDouble();

    if (decimals != 0) {
      final scale = pow(10, decimals).toInt();
      final decimalPart = 1 + random.nextInt(scale - 1);
      value += decimalPart / scale;
      value = double.parse(value.toStringAsFixed(decimals));
    }

    return DecimalNumber(value: value);
  }
}
