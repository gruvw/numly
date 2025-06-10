import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/logic/input_processing.dart";
import "package:numly/static/keys.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/play_page/components/input/virtual_key.dart";

class VirtualKeyboard extends HookWidget {
  final TextEditingController numberController;
  final Function(String numberText) onSubmit;

  const VirtualKeyboard({
    super.key,
    required this.numberController,
    required this.onSubmit,
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
        numberController.text = numberFormatter(numberController.text + text);
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
        color: Styles.colorBackground,
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

    final numberDisabled = numberText.endsWith(Keys.percent);
    final symbolDisabled =
        numberText.contains(Keys.decimal) ||
        numberText.contains(Keys.fraction) ||
        numberText.contains(Keys.percent);
    final emptyDisabled = numberText.isEmpty;
    final fractionDisabled = numberText.endsWith(Keys.fraction);

    final backspaceKey = _iconKey(
      Symbols.keyboard_backspace,
      () => numberController.text = numberController.text.substring(
        0,
        max(0, numberController.text.length - 1),
      ),
      () => numberController.text = "",
    );

    final zeroKey = _textKey(
      Keys.zero,
      numberDisabled || emptyDisabled || fractionDisabled,
    );

    // TODO enter on keyboard should submit
    final submitKey = _iconKey(Symbols.check, () {
      numberController.text = numberSubmitter(numberText);

      if (numberController.text.isNotEmpty) {
        onSubmit(numberController.text);
        numberController.text = "";
      }
    });

    final keys = [
      _rowKeys([
        _textKey(Keys.negative),
        _textKey(Keys.decimal, symbolDisabled),
        _textKey(Keys.fraction, symbolDisabled || emptyDisabled),
        _textKey(Keys.percent, symbolDisabled || emptyDisabled),
      ]),
      _textKeys(Keys.numbersRow1, numberDisabled),
      _textKeys(Keys.numbersRow2, numberDisabled),
      _textKeys(Keys.numbersRow3, numberDisabled),
      _rowKeys([backspaceKey, zeroKey, submitKey]),
    ];

    final keypad = Column(
      spacing: Styles.standardSpacing,
      children: keys,
    );

    return Container(
      color: Styles.colorBackground,
      padding: EdgeInsets.all(Styles.standardSpacing),
      child: keypad,
    );
  }
}
