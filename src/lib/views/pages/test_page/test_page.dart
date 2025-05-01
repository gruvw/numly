import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:gap/gap.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/test_page/components/input/number_input.dart";
import "package:numly/views/pages/test_page/components/input/virtual_keyboard.dart";

class TestPage extends HookWidget {
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

    final numberController = useTextEditingController();

    final content = Column(
      children: [
        Spacer(),
        NumberInput(numberController: numberController),
        Gap(Styles.standardSpacing * 4),
        VirtualKeyboard(numberController: numberController),
        Gap(Styles.standardSpacing * 4),
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
