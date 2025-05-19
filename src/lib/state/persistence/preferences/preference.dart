import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/database/tables/preference_table.drift.dart";
import "package:numly/state/persistence/preferences/providers.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/utils/language.dart";

class Preference<T> extends AsyncNotifier<T> {
  static Preference<bool> boolean({
    required String configKey,
    required bool defaultValue,
  }) {
    return Preference(
      configKey: configKey,
      defaultValue: defaultValue,
      parse: (s) => bool.parse(s),
      serialize: (v) => v.toString(),
    );
  }

  static Preference<int> integer({
    required String configKey,
    required int defaultValue,
  }) {
    return Preference(
      configKey: configKey,
      defaultValue: defaultValue,
      parse: (s) => int.parse(s),
      serialize: (v) => v.toString(),
    );
  }

  static Preference<String> string({
    required String configKey,
    required String defaultValue,
  }) {
    return Preference(
      configKey: configKey,
      defaultValue: defaultValue,
      serialize: (s) => s,
      parse: (s) => s,
    );
  }

  final String configKey;
  final T defaultValue;

  final String Function(T value) serialize;
  final T Function(String source) parse;

  Preference({
    required this.configKey,
    required this.defaultValue,
    required this.serialize,
    required this.parse,
  });

  @override
  Future<T> build() async {
    final row = await ref.watch(preferenceSourceProvider(configKey).future);
    final value = row?.nmap((row) => parse(row.value));

    return value ?? defaultValue;
  }

  Future<void> set(T value) async {
    final data = serialize(value);

    final db = ref.read(dbProvider);
    await db.into(db.preferenceTable).insertOnConflictUpdate(
          PreferenceTableCompanion.insert(
            key: configKey,
            value: data,
          ),
        );
  }
}
