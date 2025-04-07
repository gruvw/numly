import "dart:math";

import "package:flutter/services.dart";
import "package:numly/static/keys.dart";
import "package:numly/utils/language.dart";

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    // only keep allowed chars
    var result =
        newText.split("").where((char) => Keys.all.contains(char)).join();

    // handle negative sign (negative should toggle sign)
    if (result.length > 1) {
      final ending = result.substring(1, result.length);
      if (ending.contains(Keys.negative)) {
        if (result.startsWith(Keys.negative)) {
          result = ending.removeAll(Keys.negative);
        } else {
          result = Keys.negative + result.removeAll(Keys.negative);
        }
      }
    }

    // only ONE decimal OR fraction OR percent separator
    final firstIndices = [
      result.indexOf(Keys.decimal),
      result.indexOf(Keys.fraction),
      result.indexOf(Keys.percent),
    ].where((i) => i != -1);

    if (firstIndices.isNotEmpty) {
      final firstIndex = firstIndices.reduce(min);
      final prefix = result.substring(0, firstIndex + 1);
      final suffix = result
          .substring(firstIndex + 1)
          .removeAll(Keys.decimal)
          .removeAll(Keys.fraction)
          .removeAll(Keys.percent);

      result = prefix;

      // nothing else after percent
      if (!result.contains(Keys.percent)) {
        result += suffix;
      }
    }

    return TextEditingValue(text: result);
  }
}
