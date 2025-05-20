import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/overview_page.dart";
import "package:numly/views/pages/overview_page/screens/custom_screen/custom_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/categories_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/games_screen.dart";

final router = GoRouter(
  initialLocation: Routes.initial.path,
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(Routes.initial.path);
    });

    return const Scaffold(
      body: Center(
        child: Text("Routing error, redirecting..."),
      ),
    );
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return OverviewPage(
          navigationShell: navigationShell,
        );
      },
      branches: _bottomNavigationBranches.toList(),
    ),
  ],
);

final bottomNavigatorKeys = Routes.overviewBottomNavigationRoutes
    .map((_) => GlobalKey<NavigatorState>())
    .toList();

final _bottomNavigationBranches =
    Routes.overviewBottomNavigationRoutes.mapIndexed((index, route) {
  return StatefulShellBranch(
    initialLocation: route.path,
    navigatorKey: bottomNavigatorKeys[index],
    routes: [
      switch (route) {
        OverviewNavigationRoute.learn => GoRoute(
            path: route.path,
            builder: (context, state) {
              return CategoriesScreen(
                categoryRoute: CategoryRoute.levels,
                favoriteGameIdsProvider: favoriteLevelIdsProvider,
                categories: learnCategories,
              );
            },
            routes: [
              GoRoute(
                path: CategoryRoute.levels.path,
                redirect: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.categoryParameter];

                  if (!learnCategoryIds.contains(categoryId) &&
                      categoryId != CategoryRoute.favoritesCategory) {
                    // category does not exist
                    return route.path;
                  }

                  return null;
                },
                pageBuilder: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.categoryParameter]!;

                  return _slidingSubroute(
                    state: state,
                    child: GamesScreen(
                      categoryId: categoryId,
                      categories: learnCategories,
                      allGames: learnGames,
                    ),
                  );
                },
              ),
            ],
          ),
        OverviewNavigationRoute.train => GoRoute(
            path: route.path,
            builder: (context, state) {
              return CategoriesScreen(
                categoryRoute: CategoryRoute.trainings,
                favoriteGameIdsProvider: favoriteTrainingsIdsProvider,
                categories: trainCategories,
              );
            },
            routes: [
              GoRoute(
                path: CategoryRoute.trainings.path,
                redirect: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.categoryParameter];

                  if (!trainCategoryIds.contains(categoryId) &&
                      categoryId != CategoryRoute.favoritesCategory) {
                    // category does not exist
                    return route.path;
                  }

                  return null;
                },
                pageBuilder: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.categoryParameter]!;

                  return _slidingSubroute(
                    state: state,
                    child: GamesScreen(
                      categoryId: categoryId,
                      categories: trainCategories,
                      allGames: trainGames,
                    ),
                  );
                },
              ),
            ],
          ),
        OverviewNavigationRoute.custom => GoRoute(
            path: route.path,
            builder: (context, state) {
              return CustomScreen();
            },
          ),
      },
    ],
  );
});

CustomTransitionPage<dynamic> _slidingSubroute({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide from right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
