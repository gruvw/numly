import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/game/train/train.dart";
import "package:numly/state/persistence/kvs/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/navigation/router.dart";
import "package:numly/views/navigation/routes.dart";

class OverviewPage extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const OverviewPage({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastGameId = ref.watch(kvsLastGameIdProvider).value;

    final subNavigatorKey = bottomNavigatorKeys[navigationShell.currentIndex];

    // Workaround to know if the current subroute is not at its root
    final isSubrouteDeep =
        router.routerDelegate.state.path == AppRoutes.categoryRoute.path;

    final appBar = AppBar(
      title: Text(
        AppRoutes
            .overviewBottomNavigationRoutes[navigationShell.currentIndex].name
            .capitalize(),
      ),
      leading: isSubrouteDeep
          ? IconButton(
              icon: const Icon(Styles.iconPrevious),
              onPressed: () => subNavigatorKey.currentState?.maybePop(),
              color: Styles.backgroundColor,
            )
          : null,
      actions: [
        if (lastGameId != null)
          IconButton(
            onPressed: () {
              // TODO LATER (custom) handle custom game play again
              if (learnGames.containsKey(lastGameId)) {
                context.push(
                  OverviewNavigationRoute.learn.gamePath(lastGameId),
                );
              } else if (trainGames.containsKey(lastGameId)) {
                context.push(
                  OverviewNavigationRoute.train.gamePath(lastGameId),
                );
              } else {
                // lastGameId not found, should never happen
                // silently reset the persisted lastGameId
                ref.read(kvsLastGameIdProvider.notifier).reset();
              }
            },
            tooltip: "Replay",
            icon: Icon(Styles.iconRepeat),
          ),
      ],
      backgroundColor: Styles.foregroundColor,
      foregroundColor: Styles.backgroundColor,
    );

    final bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationShell.currentIndex,
      backgroundColor: Styles.foregroundColor,
      selectedItemColor: Styles.backgroundColor,
      unselectedItemColor: Styles.colorIgnored,
      onTap: (index) {
        navigationShell.goBranch(
          index,
          // go back to root of nested navigatior when clicking on a tab
          initialLocation: true,
        );
      },
      items: AppRoutes.overviewBottomNavigationRoutes.map((route) {
        return BottomNavigationBarItem(
          icon: Icon(route.icon),
          label: route.name.capitalize(),
        );
      }).toList(),
    );

    return PopScope(
      canPop: !isSubrouteDeep,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          subNavigatorKey.currentState?.maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: appBar,
        body: navigationShell,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
