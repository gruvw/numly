import "package:flutter/widgets.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/i18n/utils/hardcoded_string.dart";
import "package:numly/models/game/game.dart";

sealed class AppRoutes {
  static final initial = OverviewNavigationRoute.learn;

  static final overviewBottomNavigationRoutes = OverviewNavigationRoute.values;
  static final categoryRoute = CategoryRoute._();

  static final playRoute = PlayRoute._();
}

sealed class AppRoute {
  static const separator = "/";
  static const parameter = ":";

  String get path;
}

enum OverviewNavigationRoute implements AppRoute {
  learn("${AppRoute.separator}learn", Symbols.school),
  train("${AppRoute.separator}train", Symbols.assignment),
  custom("${AppRoute.separator}custom", Symbols.equalizer);

  @override
  final String path;

  final IconData icon;

  const OverviewNavigationRoute(this.path, this.icon);

  String gamePath(GameId gameId) {
    return path + AppRoute.separator + gameId;
  }

  String name(BuildContext context) {
    return switch (this) {
      learn => "Learn".hardcoded,
      train => "Train".hardcoded,
      custom => "Custom".hardcoded,
    };
  }
}

class CategoryRoute implements AppRoute {
  static const pathParameter = "category";
  static const favoritesCategory = "favorites";

  @override
  final String path = "${AppRoute.parameter}$pathParameter";

  CategoryRoute._();
}

class PlayRoute implements AppRoute {
  static const pathParameter = "play";

  @override
  final String path = "${AppRoute.parameter}$pathParameter";

  PlayRoute._();
}
