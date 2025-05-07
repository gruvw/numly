import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/navigation/routes.dart";

class OverviewPage extends HookWidget {
  final StatefulNavigationShell navigationShell;

  const OverviewPage({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        Values.applicationTitle,
      ),
      backgroundColor: Styles.foregroundColor,
      foregroundColor: Styles.backgroundColor,
    );

    final bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationShell.currentIndex,
      backgroundColor: Styles.foregroundColor,
      selectedItemColor: Styles.backgroundColor,
      unselectedItemColor: Styles.colorIgnored,
      onTap: navigationShell.goBranch,
      items: Routes.overviewBottomNavigationRoutes.map((route) {
        return BottomNavigationBarItem(
          icon: Icon(route.icon),
          label: route.name.capitalize(),
        );
      }).toList(),
    );

    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: appBar,
      body: navigationShell,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
