import "dart:math";

import "package:numly/models/math/random.dart";
import "package:numly/models/math/rational_number.dart";
import "package:numly/static/math/numbers.dart";
import "package:numly/utils/language.dart";

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

class UniformPoolNumberGenerator implements NumberGenerator {
  final List<NumberGenerator> pool;

  UniformPoolNumberGenerator({required this.pool})
    : assert(
        pool.isNotEmpty,
        "pool must contain at least one generator",
      );

  @override
  RationalNumber generate() {
    final generator = pool.pick(random);

    return generator.generate();
  }
}

class MinMaxDecimalNumberGenerator implements NumberGenerator {
  /// Minimum number value (inclusive), must have less (or same) decimals than [decimals]
  final RationalNumber minimum;

  /// Maximum number value (exclusive), must have less (or same) decimals than [decimals]
  final RationalNumber maximum;

  /// Number of decimals
  /// If non-zero, the number will always have a (non-zero) decimal part.
  final int decimals;

  MinMaxDecimalNumberGenerator({
    RationalNumber? minimum,
    required this.maximum,
    required this.decimals,
  }) : minimum = (minimum != null && decimals == 0 && !minimum.isInteger)
           ? minimum.add(r1)
           : minimum ?? r0,
       assert(
         minimum == null ||
             ((decimals == 0 && !minimum.isInteger)
                     ? minimum.add(r1)
                     : minimum) <=
                 maximum,
         "decimal number generation range is empty",
       ),
       assert(
         decimals >= 0,
         "`decimals` should be positive or zero",
       ),
       assert(
         maximum.isDecimal && (minimum == null || minimum.isDecimal),
         "`minimum` and `maximum` must be decimal numbers",
       );

  @override
  RationalNumber generate() {
    final minDec = minimum.intDecFracString, maxDec = maximum.intDecFracString;

    final minMatch = RationalNumber.decimalPattern.firstMatch(minDec)!;
    final minIntPart = int.parse(minMatch.group(1)!);
    final minDecPart = int.parse(minMatch.group(3) ?? "0");

    final maxMatch = RationalNumber.decimalPattern.firstMatch(maxDec)!;
    final maxIntPart = int.parse(maxMatch.group(1)!);
    final maxDecPart = int.parse(maxMatch.group(3) ?? "0");

    final intPart = randomIntRange(
      minIntPart,
      maxDecPart == 0 ? maxIntPart : maxIntPart + 1,
    );

    var number = intPart.toString();

    if (decimals != 0) {
      final scale = pow(10, decimals).toInt();
      final decimalPart = intPart == minIntPart
          ? randomIntRange(minDecPart, scale - 1)
          : (intPart == maxIntPart
                ? randomIntRange(1, maxDecPart)
                : randomIntRange(1, scale - 1));
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
  }) : assert(
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
