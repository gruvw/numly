import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class GameItem extends HookConsumerWidget {
  final Game game;

  const GameItem({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLevel = learnGames.containsKey(game.id);

    final forceShowHighScore = useState(false);

    final db = ref.read(dbProvider);
    final favoriteGameIds = ref.watch(favoriteGameIdsProvider).value;
    final highScoreTrain = ref
        .watch(highScoreSelectedTrainingLengthProvider(game.id))
        .value;
    final highScoreLearn = ref
        .watch(
          highScoreForTrainingLengthProvider((
            gameId: game.id,
            length: learnTestLength,
          )),
        )
        .value;
    final highScore = isLevel ? highScoreLearn : highScoreTrain;
    final completedLevelIds = ref.watch(completedLevelIdsProvider).value;

    toggleForceShowHighScore() =>
        forceShowHighScore.value = !forceShowHighScore.value;

    final leading = IconButton(
      onPressed: () {
        db.queries.toggleFavorite(game.id);
      },
      icon: Icon(
        Styles.iconFavorite,
        fill: favoriteGameIds?.contains(game.id) == true ? 1 : 0,
      ),
    );

    late final Widget trailing;
    if (highScore == null || completedLevelIds == null) {
      trailing = IconButton(
        onPressed: null,
        disabledColor: Styles.colorForeground,
        icon: Icon(Styles.iconNoData),
      );
    } else {
      final levelCompleted = completedLevelIds.contains(game.id);

      final highScoreSeconds =
          highScore.duration.inMilliseconds / Duration.millisecondsPerSecond;
      final highScoreText = Text(
        "${highScoreSeconds.toStringAsFixed(Values.highScoreDecimals)}s",
        style: TextStyle(
          color: levelCompleted ? Styles.colorSuccess : Styles.colorForeground,
        ),
      );

      final levelIcon = levelCompleted
          ? Icon(
              Styles.iconCompleted,
              color: Styles.colorSuccess,
            )
          : Icon(Styles.iconProgress);

      trailing = IconButton(
        onPressed: toggleForceShowHighScore,
        icon: forceShowHighScore.value || !isLevel ? highScoreText : levelIcon,
      );
    }

    return ListItem(
      title: game.title,
      leading: leading,
      subtitle: game.subtitle,
      trailing: trailing,
      onLongPress: toggleForceShowHighScore,
      onTap: () {
        context.goRelative(game.gameIdSuffix!);
      },
    );
  }
}
