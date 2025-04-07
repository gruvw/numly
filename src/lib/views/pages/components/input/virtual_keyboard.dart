import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:numly/static/keys.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/components/input/virtual_key.dart";

class VirtualKeyboard extends HookWidget {
  final TextEditingController numberController;

  const VirtualKeyboard({
    super.key,
    required this.numberController,
  });

  Widget _rowKeys(Iterable<Widget> keys) {
    return Row(
      spacing: Styles.standardSpacing,
      children: keys.toList(),
    );
  }

  Widget _textKey(String text, [bool disabled = false]) {
    return VirtualKey(
      disabled: disabled,
      onPressed: () {
        // TODO apply number formatter
        numberController.text = numberController.text + text;
      },
      child: Text(text),
    );
  }

  Widget _iconKey(
    IconData icon,
    VoidCallback onPressed, [
    VoidCallback? onLongPress,
  ]) {
    return VirtualKey(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Icon(
        icon,
        color: Styles.backgroundColor,
      ),
    );
  }

  Widget _textKeys(Iterable<String> texts, [bool disabled = false]) {
    return _rowKeys(texts.map((t) => _textKey(t, disabled)));
  }

  @override
  Widget build(BuildContext context) {
    useListenable(numberController);
    final numberText = numberController.text;

    final backspaceKey = _iconKey(
      Icons.keyboard_backspace,
      () {
        numberController.text = numberController.text
            .substring(0, numberController.text.length - 1);
      },
      () {
        numberController.text = "";
      },
    );

    // TODO enter key should submit
    final submitKey = _iconKey(Icons.check, () {
      // TODO submit press
      // TODO on submit, remove ending fraction or decimal separators
    });

    final numberDisabled = numberText.endsWith(Keys.percent);
    final symbolDisabled = numberText.contains(Keys.decimal) ||
        numberText.contains(Keys.fraction) ||
        numberText.contains(Keys.percent);
    final keys = [
      _rowKeys([
        _textKey(Keys.negative),
        _textKey(Keys.decimal, symbolDisabled),
        _textKey(Keys.fraction, symbolDisabled || numberText.isEmpty),
        _textKey(Keys.percent, symbolDisabled || numberText.isEmpty),
      ]),
      _textKeys(Keys.numbersRow1, numberDisabled),
      _textKeys(Keys.numbersRow2, numberDisabled),
      _textKeys(Keys.numbersRow3, numberDisabled),
      _rowKeys([backspaceKey, _textKey(Keys.zero, numberDisabled), submitKey]),
    ];

    final keypad = Column(
      spacing: Styles.standardSpacing,
      children: keys,
    );

    return Container(
      color: Styles.backgroundColor,
      padding: EdgeInsets.all(Styles.standardSpacing),
      child: keypad,
    );
  }
}
