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
    var isNeg = result.startsWith(Keys.negative);

    // handle negative sign (negative key should toggle sign)
    if (result.length > 1 &&
        result.substring(1, result.length).contains(Keys.negative)) {
      isNeg = !isNeg;
    }
    // remove sign during formatting, add back at the end
    result = result.removeAll(Keys.negative);

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

    // automatic 0 before decimal separator
    if (result.startsWith(Keys.decimal)) {
      result = Keys.zero + result;
    }

    // trim leading zeros (before and after fraction), leading fraction, and leading percent
    result = result.removeAll(RegExp(r"^0+|(?<=\/)0|^/+|^%+"));

    // apply sign
    if (isNeg) {
      result = Keys.negative + result;
    }

    return TextEditingValue(text: result);
  }
}
