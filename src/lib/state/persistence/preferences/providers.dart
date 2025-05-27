import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/preferences/preference.dart";
import "package:numly/state/persistence/providers.dart";

final preferenceSourceProvider = StreamProvider.family<String?, String>(
  (ref, key) {
    final db = ref.watch(dbProvider);
    final query = (db.select(db.preferenceTable)
          ..where((t) => t.key.equals(key)))
        .map((row) => row.value);

    return query.watchSingleOrNull();
  },
);

final preferenceTrainingLengthProvider =
    AsyncNotifierProvider<Preference<int>, int>(() {
  return Preference.integer(
    configKey: "training_length",
    defaultValue: 20,
  );
});

final preferenceLastGameIdProvider =
    AsyncNotifierProvider<Preference<String?>, GameId?>(() {
  return Preference.string(
    configKey: "last_game_id",
    defaultValue: "",
  ).map(
    (value) => value.isEmpty ? null : value,
    (data) => data ?? "",
  );
});
