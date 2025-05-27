import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:gap/gap.dart";
import "package:numly/models/game/game.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/play_page/components/input/number_input.dart";
import "package:numly/views/pages/play_page/components/input/virtual_keyboard.dart";

class PlayPage extends HookWidget {
  final GameId gameId;

  const PlayPage({
    super.key,
    required this.gameId,
  });

  @override
  Widget build(BuildContext context) {
    final game = allGames.where((game) => game.id == gameId).first;

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
        Text(
          game.title,
          style: TextStyle(color: Styles.backgroundColor),
        ),
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
