import "dart:math";

final Random random = Random();

/// Generates random int between `minimum` (inclusive) and `maximum` (exclusive).
/// If minimum >= maximum, generates `minimum`.
int randomIntRange(int minimum, int maximum) {
  final range = maximum - minimum;
  if (range <= 0) {
    return minimum;
  }

  return minimum + random.nextInt(range);
}

/// Generates random int between 0 (inclusive) and `maximum` (exclusive).
/// If maximum <= 0, generates 0.
int randomInt(int maximum) => randomIntRange(0, maximum);
