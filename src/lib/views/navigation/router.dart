import "package:go_router/go_router.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/overview_page.dart";
import "package:numly/views/pages/overview_page/screens/custom_screen/custom_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_screen/learn_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_screen/levels.dart";
import "package:numly/views/pages/overview_page/screens/train_screen/train_screen.dart";
import "package:numly/views/pages/overview_page/screens/train_screen/trainnings.dart";

final _bottomNavigationBranches =
    Routes.overviewBottomNavigationRoutes.map((route) {
  return StatefulShellBranch(
    initialLocation: route.path,
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
                builder: (context, state) {
                  final category =
                      state.pathParameters[CategoryRoutes.categoryParameter]!;

                  return Levels(
                    category: category,
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
                builder: (context, state) {
                  final category =
                      state.pathParameters[CategoryRoutes.categoryParameter]!;

                  return Trainnings(
                    category: category,
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
          )
      },
    ],
  );
});

final router = GoRouter(
  initialLocation: Routes.initial.path,
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
