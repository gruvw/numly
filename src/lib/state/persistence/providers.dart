import "package:drift/drift.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/data/score.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/database/core/database.dart";
import "package:numly/state/persistence/preferences/providers.dart";

final dbProvider = Provider<Database>(
  (ref) => Database.native(),
);

final highScoreForTrainingLengthProvider =
    StreamProvider.family<Score?, GameSetting>(
  (ref, gameSetting) {
    final db = ref.watch(dbProvider);

    return (db.select(db.highScoreTable)
          ..where(
            (t) =>
                t.gameId.equals(gameSetting.gameId) &
                t.length.equals(gameSetting.length),
          ))
        .watchSingleOrNull();
  },
);

final highScoreSelectedTrainingLengthProvider =
    FutureProvider.family<Score?, GameId>(
  (ref, gameId) async {
    final selectedTrainingLength =
        await ref.watch(preferenceTrainingLengthProvider.future);

    return ref.watch(
      highScoreForTrainingLengthProvider(
        (gameId: gameId, length: selectedTrainingLength),
      ).future,
    );
  },
);

final favoriteGameIdsProvider = StreamProvider<Set<GameId>>(
  (ref) {
    final db = ref.watch(dbProvider);

    return db
        .select(db.favoriteTable)
        .map((row) => row.gameId)
        .watch()
        .map((favoriteGameIds) => favoriteGameIds.toSet());
  },
);

final completedLevelIdsProvider = StreamProvider<Set<GameId>>((ref) {
  final db = ref.watch(dbProvider);

  return db
      .select(db.completedLevelsTable)
      .map((row) => row.gameId)
      .watch()
      .map((favoriteGameIds) => favoriteGameIds.toSet());
});
