import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/state/persistence/database/tables/completed_levels_table.drift.dart";
import "package:numly/state/persistence/database/tables/high_score_table.drift.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class GameItem extends HookConsumerWidget {
  final Game game;

  const GameItem({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forceShowHighScore = useState(false);

    final db = ref.watch(dbProvider);
    final favoriteGameIds = ref.watch(favoriteGameIdsProvider).valueOrNull;
    final highScore =
        ref.watch(highScoreSelectedTrainingLengthProvider(game.id)).valueOrNull;
    final completedLevelIds = ref.watch(completedLevelIdsProvider).valueOrNull;

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
      trailing = Icon(Styles.iconNoData);
    } else {
      final levelCompleted = completedLevelIds.contains(game.id);

      final highScoreText = Text(
        "${(highScore.duration.inMilliseconds / Duration.millisecondsPerSecond).toStringAsPrecision(2)}s",
        style: TextStyle(
          color: levelCompleted ? Styles.colorSuccess : Styles.foregroundColor,
        ),
      );

      final levelIcon = levelCompleted
          ? Icon(
              Styles.iconCompleted,
              color: Styles.colorSuccess,
            )
          : Icon(Styles.iconProgress);

      trailing = IconButton(
        onPressed: () => forceShowHighScore.value = !forceShowHighScore.value,
        icon: forceShowHighScore.value || !learnGameIds.contains(game.id)
            ? highScoreText
            : levelIcon,
      );
    }

    return ListItem(
      title: game.title,
      leading: leading,
      subtitle: game.subtitle,
      trailing: trailing,
      onTap: () {
        if (highScore == null) {
          db.into(db.highScoreTable).insert(
                HighScoreTableCompanion.insert(
                  gameId: game.id,
                  length: 20,
                  durationMs: 3200,
                ),
              );
        } else {
          db
              .into(db.completedLevelsTable)
              .insert(CompletedLevelsTableCompanion.insert(gameId: game.id));
        }
      },
    );
  }
}
