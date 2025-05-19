import "package:hooks_riverpod/hooks_riverpod.dart";
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
