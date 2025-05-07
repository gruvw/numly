import "package:flutter/widgets.dart";
import "package:material_symbols_icons/symbols.dart";

class Routes {
  static final initial = OverviewNavigationRoutes.train;

  static final overviewBottomNavigationRoutes = OverviewNavigationRoutes.values;
}

abstract class Route {
  String get path;
}

enum OverviewNavigationRoutes implements Route {
  learn("/learn", Symbols.school),
  train("/train", Symbols.assignment),
  custom("/custom", Symbols.equalizer);

  @override
  final String path;

  final IconData icon;

  const OverviewNavigationRoutes(this.path, this.icon);
}
