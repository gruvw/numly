import "package:flutter/material.dart";
import "package:numly/static/keys.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/components/input/virtual_key.dart";

class VirtualKeyboard extends StatelessWidget {
  final TextEditingController numberController;

  const VirtualKeyboard({
    super.key,
    required this.numberController,
  });

  Widget _rowKeys(Iterable<Widget> keys) => Row(
        spacing: Styles.standardSpacing,
        children: keys.toList(),
      );

  Widget _textKey(String text) {
    return VirtualKey(
      onPressed: () {
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

  Widget _textKeys(Iterable<String> texts) {
    return _rowKeys(texts.map(_textKey));
  }

  @override
  Widget build(BuildContext context) {
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

    final submitKey = _iconKey(Icons.check, () {
      // TODO submit press
    });

    final keys = [
      _textKeys(Keys.symbolsRow),
      _textKeys(Keys.numbersRow1),
      _textKeys(Keys.numbersRow2),
      _textKeys(Keys.numbersRow3),
      _rowKeys([backspaceKey, _textKey(Keys.zero), submitKey]),
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
