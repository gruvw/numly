import "package:flutter/widgets.dart";
import "package:material_symbols_icons/symbols.dart";

class Routes {
  static final initial = OverviewNavigationRoute.learn;

  static final overviewBottomNavigationRoutes = OverviewNavigationRoute.values;
  static final categoryRoute = CategoryRoute();

  static final playRoute = PlayRoute();
}

abstract class Route {
  String get path;
}

enum OverviewNavigationRoute implements Route {
  learn("/learn", Symbols.school),
  train("/train", Symbols.assignment),
  custom("/custom", Symbols.equalizer);

  @override
  final String path;

  final IconData icon;

  const OverviewNavigationRoute(this.path, this.icon);
}

class CategoryRoute implements Route {
  static const pathParameter = "category";
  static const favoritesCategory = "favorites";

  @override
  final String path = ":$pathParameter";
}

class PlayRoute implements Route {
  static const pathParameter = "play";

  @override
  final String path = ":$pathParameter";
}
