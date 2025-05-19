import "package:flutter_test/flutter_test.dart";
import "package:numly/views/application.dart";

import "../base/app_generator.dart";

void main() {
  testWidgets("application runs", (tester) async {
    await pumpTestApp(tester);

    expect(find.byType(Application), findsOneWidget);
  });
}
