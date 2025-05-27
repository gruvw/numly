import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/state/persistence/preferences/providers.dart";
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
    final lastGameId = ref.watch(preferenceLastGameIdProvider).valueOrNull;

    final subNavigatorKey = bottomNavigatorKeys[navigationShell.currentIndex];

    // Workaround to know if the current subroute is not at its root
    final isSubrouteDeep =
        router.routerDelegate.state.path == ":${CategoryRoute.pathParameter}";

    final appBar = AppBar(
      title: Text(
        Routes.overviewBottomNavigationRoutes[navigationShell.currentIndex].name
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
              // TODO launch last game
            },
            tooltip: "Replay",
            icon: Icon(Symbols.forward_media),
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
      items: Routes.overviewBottomNavigationRoutes.map((route) {
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
