import "package:flutter/services.dart";
import "package:numly/logic/input_processing.dart";

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(text: numberFormatter(newValue.text));
  }
}
