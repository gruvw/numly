import "package:drift/drift.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/data/score.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/state/persistence/database/core/database.dart";

final dbProvider = Provider<Database>(
  (ref) => Database.native(),
);

final highScoreProvider = StreamProvider.family<Score?, GameSetting>(
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

final favoriteGameIdsProvider = StreamProvider<List<String>>(
  (ref) {
    final db = ref.watch(dbProvider);

    return db.select(db.favoriteTable).map((row) => row.gameId).watch();
  },
);

final favortieLevelIdsProvider = Provider<AsyncValue<List<String>>>((ref) {
  final favoriteGameIds = ref.watch(favoriteGameIdsProvider);

  return favoriteGameIds.whenData((favoriteGameIds) {
    return learnGameIds
        .where((gameId) => favoriteGameIds.contains(gameId))
        .toList();
  });
});
