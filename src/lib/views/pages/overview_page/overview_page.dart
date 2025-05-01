import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/overview_page/screens/custom_screen.dart";
import "package:numly/views/pages/overview_page/screens/learn_screen.dart";
import "package:numly/views/pages/overview_page/screens/train_screen.dart";

class OverviewPage extends HookWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentScreenIndex = useState(1);

    final appBar = AppBar(
      title: Text(
        Values.applicationTitle,
      ),
      backgroundColor: Styles.foregroundColor,
      foregroundColor: Styles.backgroundColor,
    );

    final screens = [
      LearnScreen(),
      TrainScreen(),
      CustomScreen(),
    ];

    final bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentScreenIndex.value,
      backgroundColor: Styles.foregroundColor,
      selectedItemColor: Styles.backgroundColor,
      unselectedItemColor: Styles.colorIgnored,
      onTap: (index) => currentScreenIndex.value = index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Symbols.school),
          label: "Learn",
        ),
        BottomNavigationBarItem(
          icon: Icon(Symbols.assignment),
          label: "Train",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.equalizer),
          label: "Custom",
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Styles.backgroundColor,
      body: screens[currentScreenIndex.value],
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
