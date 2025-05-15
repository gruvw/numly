import "package:numly/static/math/numbers.dart";
import "package:numly/utils/math.dart";

// https://github.com/dart-lang/sdk/issues/46180
BigInt _gcd(BigInt a, BigInt b) {
  while (b != i0) {
    final t = b;
    b = a % b;
    a = t;
  }
  return a;
}

class RationalNumber implements Comparable<RationalNumber> {
  static final fractionalPattern = RegExp(r"^(-?\d+)/(\d+)$");
  static final percentPattern = RegExp(r"^(-?\d+)%$");
  static final decimalPattern = RegExp(r"^(-?\d+)(\.(\d+))?$");

  final BigInt numerator;
  final BigInt denominator;

  /// Only use with reduced form, numerator and denominator coprime
  RationalNumber._reduced({
    required this.numerator,
    required this.denominator,
  })  : assert(
          denominator >= i1,
          "denominator ($denominator) must be larger than 1",
        ),
        assert(
          _gcd(numerator.abs(), denominator) == i1,
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
        denominator: i1,
      );
    }

    // division by 0
    if (denominator == i0) {
      throw ArgumentError("zero is not a valid denominator");
    }

    // 0/x = 0
    if (numerator == i0) {
      return RationalNumber._reduced(
        numerator: i0,
        denominator: i1,
      );
    }

    // make denominator positive
    if (denominator < i0) {
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

  factory RationalNumber.fromInt(
    int numerator, [
    int denominator = 1,
  ]) {
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
        i100,
      );
    }

    final decimalMatch = decimalPattern.firstMatch(text);
    if (decimalMatch != null) {
      final intPart = decimalMatch.group(1)!;
      final decPart = decimalMatch.group(2) ?? "";

      final numerator = intPart + decPart;
      final denominator = i10.pow(decPart.length);

      return RationalNumber(
        BigInt.parse(numerator),
        denominator,
      );
    }

    throw FormatException("$text is not a valid rational number format");
  }

  static RationalNumber? tryParse(String text) {
    try {
      return RationalNumber.parse(text);
    } catch (_) {
      return null;
    }
  }

  late final isNegative = numerator < i0;
  late final isInteger = denominator == i1;
  late final isPercentage = i100 % denominator == i1;

  late final isDecimal = () {
    if (isInteger) {
      return true;
    }

    var d = denominator;
    while (d % i5 == i0) {
      d ~/= i5;
    }
    while (d % i2 == i0) {
      d ~/= i2;
    }

    return d == i1;
  }();

  late final intFracString =
      isInteger ? numerator.toString() : "$numerator/$denominator";
  late final intDecFracString = () {
    if (isInteger) {
      return numerator.toString();
    }

    if (!isDecimal) {
      return intFracString;
    }

    final intPart = numerator ~/ denominator;
    var decimal = "$intPart.";

    var remainder = numerator % denominator;
    while (remainder != i0) {
      remainder *= i10;
      final digit = remainder ~/ denominator;
      decimal += digit.toString();
      remainder %= denominator;
    }

    return decimal;
  }();
  late final percentString = () {
    if (!isPercentage) {
      throw FormatException("$this is not a valid percent number");
    }

    return "$numerator%";
  }();

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
  int compareTo(RationalNumber other) {
    return (numerator * other.denominator)
        .compareTo(other.numerator * denominator);
  }

  bool operator <(RationalNumber other) => compareTo(other) < 0;
  bool operator <=(RationalNumber other) => compareTo(other) <= 0;
  bool operator >(RationalNumber other) => compareTo(other) > 0;
  bool operator >=(RationalNumber other) => compareTo(other) >= 0;

  @override
  String toString() => intFracString;
}
