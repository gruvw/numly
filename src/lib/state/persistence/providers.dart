import "package:drift/drift.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/data/score.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
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

final favoriteLevelIdsProvider = Provider<AsyncValue<Set<GameId>>>((ref) {
  final favoriteGameIds = ref.watch(favoriteGameIdsProvider);

  return favoriteGameIds.whenData((favoriteGameIds) {
    return learnGameIds
        .where((gameId) => favoriteGameIds.contains(gameId))
        .toSet();
  });
});

final favoriteTrainingsIdsProvider = Provider<AsyncValue<Set<GameId>>>((ref) {
  final favoriteGameIds = ref.watch(favoriteGameIdsProvider);

  return favoriteGameIds.whenData((favoriteGameIds) {
    return trainGameIds
        .where((gameId) => favoriteGameIds.contains(gameId))
        .toSet();
  });
});

final completedLevelIdsProvider = StreamProvider<Set<GameId>>((ref) {
  final db = ref.watch(dbProvider);

  return db
      .select(db.completedLevelsTable)
      .map((row) => row.gameId)
      .watch()
      .map((favoriteGameIds) => favoriteGameIds.toSet());
});

// final completedLevelIdsForCategoryProvider =
//     Provider.family<AsyncValue<Set<GameId>>, CategoryId>((ref, categoryId) {
//   final completedLevelIds = ref.watch(completedLevelIdsProvider);

//   return completedLevelIds.whenData(
//     (completedLevelIds) => completedLevelIds
//         .where((levelId) => levelId.startsWith(categoryId))
//         .toSet(),
//   );
// });
