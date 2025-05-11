import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/overview_page.dart";
import "package:numly/views/pages/overview_page/screens/custom_screen/custom_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_screen/learn_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_screen/levels.dart";
import "package:numly/views/pages/overview_page/screens/train_screen/train_screen.dart";
import "package:numly/views/pages/overview_page/screens/train_screen/trainnings.dart";

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
        OverviewNavigationRoutes.learn => GoRoute(
            path: route.path,
            builder: (context, state) {
              return LearnScreen();
            },
            routes: [
              GoRoute(
                path: CategoryRoutes.levels.path,
                pageBuilder: (context, state) {
                  final category =
                      state.pathParameters[CategoryRoutes.categoryParameter]!;

                  return _slidingSubroute(
                    state: state,
                    child: Levels(
                      category: category,
                    ),
                  );
                },
              ),
            ],
          ),
        OverviewNavigationRoutes.train => GoRoute(
            path: route.path,
            builder: (context, state) {
              return TrainScreen();
            },
            routes: [
              GoRoute(
                path: CategoryRoutes.trainnigs.path,
                pageBuilder: (context, state) {
                  final category =
                      state.pathParameters[CategoryRoutes.categoryParameter]!;

                  return _slidingSubroute(
                    state: state,
                    child: Trainnings(
                      category: category,
                    ),
                  );
                },
              ),
            ],
          ),
        OverviewNavigationRoutes.custom => GoRoute(
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
