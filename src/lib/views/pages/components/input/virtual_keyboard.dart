import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/components/input/virtual_key.dart";

class VirtualKeyboard extends StatelessWidget {
  const VirtualKeyboard({super.key});

  Widget _rowKeys(Iterable<Widget> keys) => Row(
        spacing: Styles.standardSpacing,
        children: keys.toList(),
      );

  Widget _textKey(String text) {
    return VirtualKey(
      onPressed: () {
        // TODO on text key press
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

  Widget _textKeys(List<String> texts) {
    return _rowKeys(texts.map(_textKey));
  }

  @override
  Widget build(BuildContext context) {
    final backspaceKey = _iconKey(
      Icons.keyboard_backspace,
      () {
        // TODO backspace press
      },
      () {
        // TODO backspace long press
      },
    );

    final submitKey = _iconKey(Icons.check, () {
      // TODO submit press
    });

    final keys = [
      _textKeys(["-", ".", "/", "%"]),
      _textKeys(["1", "2", "3"]),
      _textKeys(["4", "5", "6"]),
      _textKeys(["7", "8", "9"]),
      _textKeys(["7", "8", "9"]),
      _rowKeys([backspaceKey, _textKey("0"), submitKey]),
    ];

    final keypad = Column(
      spacing: Styles.standardSpacing,
      children: keys,
    );

    return Container(
      color: Styles.backgroundColor,
      child: keypad,
    );
  }
}
