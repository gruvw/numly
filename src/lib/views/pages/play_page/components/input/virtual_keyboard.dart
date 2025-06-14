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
  final bool submitOnly;
  final Function(String numberText) onSubmit;

  const VirtualKeyboard({
    super.key,
    required this.numberController,
    required this.submitOnly,
    required this.onSubmit,
  });

  Widget _rowKeys(Iterable<Widget> keys) {
    return Row(
      spacing: Styles.standardSpacing,
      children: keys.toList(),
    );
  }

  Widget _textKey(String text, {bool disabled = false}) {
    return VirtualKey(
      disabled: disabled,
      onPressed: () {
        numberController.text = numberFormatter(numberController.text + text);
      },
      child: Text(text),
    );
  }

  Widget _textKeys(Iterable<String> texts, {bool disabled = false}) {
    return _rowKeys(texts.map((t) => _textKey(t, disabled: disabled)));
  }

  Widget _iconKey(
    IconData icon,
    VoidCallback onPressed, {
    VoidCallback? onLongPress,
    bool disabled = false,
  }) {
    return VirtualKey(
      disabled: disabled,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    useListenable(numberController);
    final numberText = numberController.text;

    final emptyDisabled = numberText.isEmpty;
    final numberDisabled = numberText.endsWith(Keys.percent) || submitOnly;
    final symbolDisabled =
        numberText.contains(Keys.decimal) ||
        numberText.contains(Keys.fraction) ||
        numberText.contains(Keys.percent) ||
        submitOnly;
    final zeroDivisionDisabled = numberText.endsWith(Keys.fraction);
    final zeroValueDisabled = numberText.contains(RegExp(r"^-?0$"));

    final backspaceKey = _iconKey(
      Symbols.keyboard_backspace,
      () {
        numberController.text = numberController.text.substring(
          0,
          max(0, numberController.text.length - 1),
        );
      },
      onLongPress: () => numberController.text = "",
      disabled: emptyDisabled || submitOnly,
    );

    // TODO enter on keyboard should submit
    final submitKey = _iconKey(
      Symbols.check,
      () {
        numberController.text = numberSubmitter(numberText);

        onSubmit(numberController.text);
        numberController.text = "";
      },
      disabled: emptyDisabled && !submitOnly,
    );

    final zeroKey = _textKey(
      Keys.zero,
      disabled: numberDisabled || zeroDivisionDisabled || zeroValueDisabled,
    );

    final keys = [
      _rowKeys([
        _textKey(Keys.negative, disabled: submitOnly),
        _textKey(Keys.decimal, disabled: symbolDisabled),
        _textKey(
          Keys.fraction,
          disabled: symbolDisabled || emptyDisabled || zeroValueDisabled,
        ),
        _textKey(
          Keys.percent,
          disabled: symbolDisabled || emptyDisabled || zeroValueDisabled,
        ),
      ]),
      _textKeys(Keys.numbersRow1, disabled: numberDisabled),
      _textKeys(Keys.numbersRow2, disabled: numberDisabled),
      _textKeys(Keys.numbersRow3, disabled: numberDisabled),
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
