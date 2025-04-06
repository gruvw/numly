import "package:flutter/material.dart";
import "package:numly/views/pages/test_page.dart";

enum Routes {
  test("test");

  static const initial = test;

  final String name;

  const Routes(this.name);

  static Routes parse(String name) {
    return Routes.values.firstWhere((r) => r.name == name);
  }

  static Route generateRoute(RouteSettings settings) {
    final route = Routes.parse(settings.name ?? Routes.initial.name);
    return MaterialPageRoute(builder: (_) => route.page(settings.arguments));
  }

  Widget page(Object? args) {
    switch (this) {
      case test:
        return const TestPage();
    }
  }
}
