import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:gap/gap.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/kvs/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/play_page/components/input/number_input.dart";
import "package:numly/views/pages/play_page/components/input/virtual_keyboard.dart";

class PlayPage extends HookConsumerWidget {
  /// The id of the game to play.
  /// Assumed to be a valid game id.
  final GameId gameId;

  const PlayPage({
    super.key,
    required this.gameId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(kvsLastGameIdProvider.notifier).set(gameId);
      return null;
    });

    final endlessMode = ref.watch(kvsEndlessModeProvider).value;

    // TODO custom games retrieval
    final game = allGames[gameId]!;

    final appBar = AppBar(
      title: Text(
        Values.applicationTitle,
      ),
      actions: [
        if (endlessMode != null)
          IconButton(
            onPressed: () {
              ref.read(kvsEndlessModeProvider.notifier).set(!endlessMode);
            },
            tooltip: "Endless",
            icon: Icon(
              Styles.iconEndless,
              fill: endlessMode ? 1 : 0,
            ),
          ),
        IconButton(
          onPressed: endlessMode == true
              ? null
              : () {
                  // TODO restart current game
                },
          tooltip: "Restart",
          icon: Icon(Styles.iconRepeat),
          disabledColor: Styles.colorIgnored,
        ),
      ],
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
