import "package:numly/static/math/numbers.dart";

extension NthRoot on BigInt {
  /// Returns x if there is a integer x such that x^n = this
  BigInt? integerNthRoot(int n) {
    if (n <= 0) {
      throw ArgumentError("$n must be a positive number");
    }

    // the nth root of 0 is always 0
    if (this == i0) return i0;

    // the 1st root of any number is itself
    if (n == 1) return this;

    // the nth root of 1 is always 1
    if (this == i1) return i1;

    // negative number
    if (this < i0) {
      // if n is even, a negative number doesn't have a real nth root
      if (n.isEven) {
        return null;
      }

      // if n is odd, find the nth root of the absolute value and negate it
      final absRoot = abs().integerNthRoot(n);
      return absRoot != null ? -absRoot : null;
    }

    // binary search to find the positive integer x such that x^n = this (where this is positive)
    var low = i1;
    var high = this; // upper bound

    while (low <= high) {
      var mid = (low + high) ~/ i2;

      // calculate mid^n
      var result = mid.pow(n);

      var comparison = result.compareTo(this);

      if (comparison == 0) {
        return mid; // Found exact root
      } else if (comparison < 0) {
        low = mid + i1; // Search in upper half
      } else {
        high = mid - i1; // Search in lower half
      }
    }

    // irrational root
    return null;
  }
}
