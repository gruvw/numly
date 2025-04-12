import "package:numly/utils/math.dart";

final _i2 = BigInt.from(2);
final _i5 = BigInt.from(5);
final _i10 = BigInt.from(10);
final _i100 = BigInt.from(100);

// https://github.com/dart-lang/sdk/issues/46180
BigInt _gcd(BigInt a, BigInt b) {
  while (b != BigInt.zero) {
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

  final BigInt numerator;
  final BigInt denominator;

  late final isNegative = numerator < BigInt.zero;
  late final isInteger = denominator == BigInt.one;
  late final isPercentage = _i100 % denominator == BigInt.zero;

  bool get isDecimal {
    if (isInteger) {
      return true;
    }

    var d = denominator;
    while (d % _i5 == BigInt.zero) {
      d ~/= _i5;
    }
    while (d % _i2 == BigInt.zero) {
      d ~/= _i2;
    }

    return d == BigInt.one;
  }

  String get fractionalString => "$numerator/$denominator";
  String get intDecFracString {
    if (isInteger) {
      return numerator.toString();
    }

    if (!isDecimal) {
      return fractionalString;
    }

    final intPart = numerator ~/ denominator;
    var decimal = "$intPart.";

    var remainder = numerator % denominator;
    while (remainder != BigInt.zero) {
      remainder *= _i10;
      final digit = remainder ~/ denominator;
      decimal += digit.toString();
      remainder %= denominator;
    }

    return decimal;
  }

  /// Only use with reduced form, numerator and denominator coprime
  RationalNumber._reduced({
    required this.numerator,
    required this.denominator,
  })  : assert(
          denominator >= BigInt.one,
          "denominator ($denominator) must be larger than 1",
        ),
        assert(
          _gcd(numerator.abs(), denominator) == BigInt.one,
          "numerator ($numerator) and denominator ($denominator) must be coprime",
        );

  factory RationalNumber(
    BigInt numerator, [
    BigInt? denominator,
  ]) {
    // integer number
    if (denominator == null) {
      return RationalNumber._reduced(
        numerator: numerator,
        denominator: BigInt.one,
      );
    }

    // division by 0
    if (denominator == BigInt.zero) {
      throw ArgumentError("zero is not a valid denominator");
    }

    // 0/x = 0
    if (numerator == BigInt.zero) {
      return RationalNumber._reduced(
        numerator: BigInt.zero,
        denominator: BigInt.one,
      );
    }

    // make denominator positive
    if (denominator < BigInt.zero) {
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

  factory RationalNumber.fromInt(int numerator, [int denominator = 1]) {
    return RationalNumber(
      BigInt.from(numerator),
      BigInt.from(denominator),
    );
  }

  factory RationalNumber.parse(String text) {
    final fractionalMatch = fractionalPattern.firstMatch(text);
    if (fractionalMatch != null) {
      final numerator = fractionalMatch.group(1)!;
      final denominator = fractionalMatch.group(2)!;
      return RationalNumber(
        BigInt.parse(numerator),
        BigInt.parse(denominator),
      );
    }

    final percentMatch = percentPattern.firstMatch(text);
    if (percentMatch != null) {
      final numerator = percentMatch.group(1)!;
      return RationalNumber(
        BigInt.parse(numerator),
        _i100,
      );
    }

    final decimalMatch = decimalPattern.firstMatch(text);
    if (decimalMatch != null) {
      final intPart = decimalMatch.group(1)!;
      final decPart = decimalMatch.group(2) ?? "";

      final numerator = intPart + decPart;
      final denominator = _i10.pow(decPart.length);

      return RationalNumber(
        BigInt.parse(numerator),
        denominator,
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
      numerator * other.numerator,
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

    final exponent = other.numerator.toInt(); // always non-negative
    final numeratorPow = numerator.pow(exponent);
    final denominatorPow = denominator.pow(exponent);

    final base = other.denominator; // always >= 1
    final numeratorPowRoot = numeratorPow.integerNthRoot(base.toInt());
    final denominatorPowRoot = denominatorPow.integerNthRoot(base.toInt());
    if (numeratorPowRoot == null || denominatorPowRoot == null) {
      throw ArgumentError(
        "invalid power (n-th root isn't rational) for ($this)^($other)",
      );
    }

    return RationalNumber(
      numeratorPowRoot,
      denominatorPowRoot,
    );
  }

  RationalNumber nrt(RationalNumber other) {
    if (!other.isInteger) {
      throw ArgumentError("n-th root n = $other is not an integer");
    }

    return pow(other.inv);
  }

  bool equals(RationalNumber other) {
    return numerator == other.numerator && denominator == other.denominator;
  }

  int toInteger() {
    if (!isInteger || !numerator.isValidInt) {
      throw ArgumentError("cannot convert $this to integer");
    }

    return numerator.toInt();
  }

  @override
  String toString() => isInteger ? numerator.toString() : fractionalString;
}
