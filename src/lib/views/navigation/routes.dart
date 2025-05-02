import "package:flutter/material.dart";
import "package:numly/views/pages/overview_page/overview_page.dart";
import "package:numly/views/pages/test_page/test_page.dart";

enum Routes {
  overview("overview"),
  test("test");

  static const initial = overview;

  final String name;

  const Routes(this.name);

  static Routes parse(String name) {
    return Routes.values.firstWhere(
      (r) => r.name == name,
      orElse: () => throw Exception(
        "Route error: named route '$name' is invalid!",
      ),
    );
  }

  static Route generateRoute(RouteSettings settings) {
    final route = Routes.parse(settings.name ?? Routes.initial.name);
    return MaterialPageRoute(builder: (_) => route.page(settings.arguments));
  }

  Widget page(Object? args) {
    switch (this) {
      case overview:
        return const OverviewPage();
      case test:
        return const TestPage();
    }
  }
}
