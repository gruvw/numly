import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/state/persistence/tables/high_score_table.drift.dart";
import "package:numly/utils/language.dart";

class CustomScreen extends ConsumerWidget {
  const CustomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gameId = "testGame";
    final highScore = ref.watch(highScoreProvider(gameId));
    final db = ref.watch(dbProvider);

    final highScoreSeconds = highScore.whenData(
      (highScore) =>
          highScore?.nmap((highScore) => highScore.duration.inSeconds),
    );

    final highScoreText = highScoreSeconds.maybeWhen(
      data: (seconds) => seconds == null ? "NONE" : seconds.toString(),
      orElse: () => "LOADING",
    );

    return Center(
      child: InkWell(
        child: Text("Custom - $highScoreText"),
        onTap: () => highScoreSeconds.whenData((seconds) {
          db.into(db.highScoreTable).insertOnConflictUpdate(
                HighScoreTableCompanion.insert(
                  gameId: "testGame",
                  questionCount: 10,
                  durationMs: seconds == null ? 1000 : (seconds + 1) * 1000,
                ),
              );
        }),
      ),
    );
  }
}
