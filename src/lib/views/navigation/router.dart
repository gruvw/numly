import "package:go_router/go_router.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/overview_page.dart";
import "package:numly/views/pages/overview_page/screens/custom_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_screen.dart";
import "package:numly/views/pages/overview_page/screens/train_screen.dart";

final router = GoRouter(
  initialLocation: Routes.initial.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return OverviewPage(
          navigationShell: navigationShell,
        );
      },
      branches: Routes.overviewBottomNavigationRoutes.map((route) {
        return StatefulShellBranch(
          routes: [
            switch (route) {
              OverviewNavigationRoutes.learn => GoRoute(
                  path: route.path,
                  builder: (context, state) {
                    return LearnScreen();
                  },
                ),
              OverviewNavigationRoutes.train => GoRoute(
                  path: route.path,
                  builder: (context, state) {
                    return TrainScreen();
                  },
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
      }).toList(),
    ),
  ],
);
