import "package:drift/native.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/database/core/database.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/views/application.dart";

Future<ProviderContainer> pumpTestApp(
  WidgetTester tester, {
  List<Override> overrides = const [],
}) async {
  final inMemoryDb = Database(NativeDatabase.memory());
  addTearDown(inMemoryDb.close);

  final providerOverrides = [
    dbProvider.overrideWithValue(inMemoryDb),
    ...overrides,
  ];
  final container = ProviderContainer(
    overrides: providerOverrides,
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: Application(),
    ),
  );
  await tester.pumpAndSettle();

  return container;
}
