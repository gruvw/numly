import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/components/input/virtual_keyboard.dart";

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        Values.applicationTitle,
      ),
      backgroundColor: Styles.foregroundColor,
      foregroundColor: Styles.backgroundColor,
    );

    final content = Column(
      children: [
        Spacer(),
        VirtualKeyboard(),
      ],
    );

    return Scaffold(
      backgroundColor: Styles.foregroundColor,
      appBar: appBar,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Styles.contentMaxWidth,
          ),
          child: content,
        ),
      ),
    );
  }
}
