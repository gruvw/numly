import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/overview_page.dart";
import "package:numly/views/pages/overview_page/screens/custom_screen/custom_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/categories_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/games_screen.dart";
import "package:numly/views/pages/play_page/play_page.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.initial.path,
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(Routes.initial.path);
    });

    return Scaffold(
      body: Center(
        child: Text("Routing error, redirecting..."),
      ),
    );
  },
  routes: [
    StatefulShellRoute(
      // not using indexedStack to avoid conserving the state
      navigatorContainerBuilder: (context, navigationShell, children) {
        return children[navigationShell.currentIndex];
      },
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
        // TODO fuse learn and train
        OverviewNavigationRoute.learn => GoRoute(
            path: route.path,
            builder: (context, state) {
              return CategoriesScreen(
                allGamesForType: learnGames,
                categories: learnCategories,
              );
            },
            routes: [
              GoRoute(
                path: Routes.categoryRoute.path,
                redirect: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.pathParameter];

                  if (!learnCategoryIds.contains(categoryId) &&
                      categoryId != CategoryRoute.favoritesCategory) {
                    // category does not exist
                    return route.path;
                  }

                  return null;
                },
                pageBuilder: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.pathParameter]!;

                  return _slidingSubroute(
                    state: state,
                    child: GamesScreen(
                      categoryId: categoryId,
                      categories: learnCategories,
                      allGamesForType: learnGames,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: Routes.playRoute.path,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final categoryId =
                          state.pathParameters[CategoryRoute.pathParameter]!;
                      final gameIdSuffix =
                          state.pathParameters[PlayRoute.pathParameter]!;

                      return PlayPage(
                        gameId: Category.subId(categoryId, gameIdSuffix),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        OverviewNavigationRoute.train => GoRoute(
            path: route.path,
            builder: (context, state) {
              return CategoriesScreen(
                allGamesForType: trainGames,
                categories: trainCategories,
              );
            },
            routes: [
              GoRoute(
                path: Routes.categoryRoute.path,
                redirect: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.pathParameter];

                  if (!trainCategoryIds.contains(categoryId) &&
                      categoryId != CategoryRoute.favoritesCategory) {
                    // category does not exist
                    return route.path;
                  }

                  return null;
                },
                pageBuilder: (context, state) {
                  final categoryId =
                      state.pathParameters[CategoryRoute.pathParameter]!;

                  return _slidingSubroute(
                    state: state,
                    child: GamesScreen(
                      categoryId: categoryId,
                      categories: trainCategories,
                      allGamesForType: trainGames,
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

      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
