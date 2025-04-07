import "package:flutter/material.dart";

extension RemoveAll on String {
  String removeAll(Pattern pattern) => replaceAll(pattern, "");
}

extension Coloren on Color {
  Color darken(double amount) {
    assert(amount >= 0 && amount <= 1);

    return Color.lerp(this, Colors.black, amount)!;
  }

  Color lighten(double amount) {
    assert(amount >= 0 && amount <= 1);

    return Color.lerp(this, Colors.white, amount)!;
  }
}
