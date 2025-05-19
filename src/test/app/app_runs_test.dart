import "package:flutter_test/flutter_test.dart";
import "package:numly/views/application.dart";
import "package:numly/views/navigation/router.dart";
import "package:numly/views/navigation/routes.dart";

import "../helpers/app_generator.dart";

void main() {
  testWidgets("application runs", (tester) async {
    await pumpTestApp(tester);

    expect(find.byType(Application), findsOneWidget);

    expect(
      router.state.path,
      Routes.initial.path,
      reason: "application should be on initial route",
    );
  });
}
