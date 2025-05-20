import "package:flutter/widgets.dart";
import "package:material_symbols_icons/symbols.dart";

class Routes {
  static final initial = OverviewNavigationRoute.train;

  static final overviewBottomNavigationRoutes = OverviewNavigationRoute.values;
  static final categoryRoutes = CategoryRoute.values;
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

enum CategoryRoute implements Route {
  levels(OverviewNavigationRoute.learn),
  trainings(OverviewNavigationRoute.train);

  static const categoryParameter = "category";
  static const favoritesCategory = "favorites";

  @override
  final String path = ":$categoryParameter";

  final OverviewNavigationRoute navigationRoute;

  const CategoryRoute(this.navigationRoute);

  String get favoritesCategoryPath => categoryPath(favoritesCategory);

  String categoryPath(String category) {
    return "${navigationRoute.path}/$category";
  }
}
