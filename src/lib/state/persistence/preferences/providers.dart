import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/database/tables/preference_table.drift.dart";
import "package:numly/state/persistence/preferences/preference.dart";
import "package:numly/state/persistence/providers.dart";

final preferenceSourceProvider =
    StreamProvider.family<PreferenceTableData?, String>(
  (ref, key) {
    final db = ref.watch(dbProvider);
    final query = db.select(db.preferenceTable)
      ..where((t) => t.key.equals(key));

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
