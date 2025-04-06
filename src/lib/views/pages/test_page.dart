import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/components/input/virtual_keyboard.dart";

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Values.applicationTitle,
        ),
        backgroundColor: Styles.foregroundColor,
        foregroundColor: Styles.backgroundColor,
      ),
      body: Column(
        children: [
          Spacer(),
          VirtualKeyboard(),
        ],
      ),
    );
  }
}
