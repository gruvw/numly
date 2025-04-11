import "dart:math" as math;

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
  late final isPercentage = 100 % denominator == 0;
  late final isDecimal = () {
    if (isInteger) {
      return true;
    }

    var d = denominator;
    while (d % 5 == 0) {
      d ~/= 5;
    }
    while (d % 2 == 0) {
      d ~/= 2;
    }
    return d == 1;
  }();

  late final fractionalString = "$numerator/$denominator";
  late final intDecFracString = () {
    if (isInteger) {
      return numerator.toString();
    }

    if (!isDecimal) {
      return fractionalString;
    }

    final intPart = numerator ~/ denominator;
    var decimal = "$intPart.";

    var remainder = numerator % denominator;
    while (remainder != 0) {
      remainder *= 10;
      final digit = remainder ~/ denominator;
      decimal += digit.toString();
      remainder %= denominator;
    }

    return decimal;
  }();

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

  factory RationalNumber.parse(String text) {
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
      final denominator = math.pow(10, decPart.length);

      return RationalNumber(
        int.parse(numerator),
        denominator.toInt(),
      );
    }

    throw FormatException("$text is not a valid rational number format");
  }

  RationalNumber get neg => RationalNumber(-numerator, denominator);
  RationalNumber get inv => RationalNumber(denominator, numerator);

  RationalNumber add(RationalNumber other) {
    return RationalNumber(
      numerator * other.denominator + other.numerator * denominator,
      denominator * other.denominator,
    );
  }

  RationalNumber sub(RationalNumber other) {
    return RationalNumber(
      numerator * other.denominator - other.numerator * denominator,
      denominator * other.denominator,
    );
  }

  RationalNumber mul(RationalNumber other) {
    return RationalNumber(
      numerator * other.denominator - other.numerator * denominator,
      denominator * other.denominator,
    );
  }

  RationalNumber div(RationalNumber other) {
    return RationalNumber(
      numerator * other.denominator,
      denominator * other.numerator,
    );
  }

  RationalNumber pow(RationalNumber other) {
    if (other.isNegative) {
      return inv.pow(other.neg);
    }

    // TODO finish power for square root, check if result is integer
    return RationalNumber(
      math.pow(numerator, exponent).toInt(),
      math.pow(denominator, exponent).toInt(),
    );
  }

  RationalNumber nrt(RationalNumber other) {
    if (!other.isInteger) {
      throw ArgumentError("n-th root n = $other is not an integer");
    }

    return pow(other.inv);
  }

  int toInt() {
    if (!isInteger) {
      throw ArgumentError("cannot convert $this to integer");
    }

    return numerator;
  }

  @override
  String toString() => isInteger ? numerator.toString() : fractionalString;
}
