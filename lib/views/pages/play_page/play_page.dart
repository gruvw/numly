import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/i18n/utils/context_locale.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/kvs/providers.dart";
import "package:numly/state/view/test_notifier.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/play_page/components/test_area.dart";

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(kvsLastGameIdProvider.notifier).set(gameId);
      });
      return null;
    }, []);

    // TODO LATER (custom) games retrieval
    final game = allGames[gameId]!;

    final testStateProvider = testStateNotifierProvider(game);
    final testStateNotifier = ref.watch(testStateProvider.notifier);
    final testStateAsync = ref.watch(testStateProvider);

    final endlessAsync = ref.watch(kvsEndlessModeProvider);

    final restartButton = IconButton(
      onPressed: testStateNotifier.restart,
      tooltip: context.l10n.restartHint,
      icon: Icon(Styles.iconRepeat),
      disabledColor: Styles.colorIgnored,
    );

    final endlessButton = endlessAsync.whenOrNull(
      data: (isEndless) => IconButton(
        onPressed: () =>
            ref.read(kvsEndlessModeProvider.notifier).set(!isEndless),
        tooltip: context.l10n.endlessHint,
        icon: Icon(
          Styles.iconEndless,
          fill: isEndless ? 1 : 0,
        ),
      ),
    );

    final appBar = AppBar(
      title: Text(context.l10n.applicationTitle),
      actions: [
        if (endlessButton != null) endlessButton,
        restartButton,
      ],
      backgroundColor: Styles.colorForeground,
      foregroundColor: Styles.colorBackground,
    );

    final content = Column(
      children: [
        Text(
          game.title(context.l10n),
          style: TextStyle(color: Styles.colorForeground),
        ),
        testStateAsync.maybeWhen(
          data: (testState) => TestArea(
            game: game,
            testState: testState,
          ),
          orElse: () => CircularProgressIndicator(
            color: Styles.colorForeground,
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Styles.colorBackground,
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
