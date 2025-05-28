import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/database/tables/preference_table.drift.dart";
import "package:numly/state/persistence/preferences/providers.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/utils/language.dart";

class PreferenceNotifier<T> extends AsyncNotifier<T> {
  static PreferenceNotifier<bool> boolean({
    required String configKey,
    required bool defaultValue,
  }) {
    return PreferenceNotifier(
      configKey: configKey,
      defaultValue: defaultValue,
      parse: (s) => bool.parse(s),
      serialize: (v) => v.toString(),
    );
  }

  static PreferenceNotifier<int> integer({
    required String configKey,
    required int defaultValue,
  }) {
    return PreferenceNotifier(
      configKey: configKey,
      defaultValue: defaultValue,
      parse: (s) => int.parse(s),
      serialize: (v) => v.toString(),
    );
  }

  static PreferenceNotifier<String> string({
    required String configKey,
    required String defaultValue,
  }) {
    return PreferenceNotifier(
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

  late final _db = ref.read(dbProvider);

  PreferenceNotifier({
    required this.configKey,
    required this.defaultValue,
    required this.serialize,
    required this.parse,
  });

  @override
  Future<T> build() async {
    final row = await ref.watch(preferenceSourceProvider(configKey).future);
    final value = row?.nmap((source) => parse(source));

    return value ?? defaultValue;
  }

  Future<void> set(T value) async {
    final data = serialize(value);

    await _db.into(_db.preferenceTable).insertOnConflictUpdate(
          PreferenceTableCompanion.insert(
            key: configKey,
            value: data,
          ),
        );
  }

  Future<void> reset() async {
    final delete = (_db.delete(_db.preferenceTable))
      ..where((preference) => preference.key.equals(configKey));

    await delete.go();
  }

  PreferenceNotifier<E> map<E>(
    E Function(T) map,
    T Function(E) reverse,
  ) {
    return PreferenceNotifier<E>(
      configKey: configKey,
      defaultValue: map(defaultValue),
      serialize: (value) => serialize(reverse(value)),
      parse: (source) => map(parse(source)),
    );
  }
}
