import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/overview_page/screens/components/category_item.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/custom_screen.dart";
import "package:numly/views/pages/overview_page/screens/train_screen.dart";

class OverviewPage extends HookWidget {
  const OverviewPage({super.key});

  Widget _buildTabNavigator(Key key) {
    return Navigator(
      key: key,
      onGenerateRoute: (settings) {
        final arg = settings.arguments;
        if (arg != null && arg is List<Widget>) {
          return MaterialPageRoute(
            builder: (context) {
              return FavoriteDividedListView(
                favorites: [],
                children: arg,
              );
            },
          );
        }

        return MaterialPageRoute(
          builder: (context) {
            final items = [
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
                onTap: () => Navigator.pushNamed(
                  context,
                  "",
                  arguments: [
                    CategoryItem(
                      title: "HeySub",
                      subtitle: "heySub",
                    ),
                    CategoryItem(
                      title: "HeySub",
                      subtitle: "heySub",
                    ),
                    CategoryItem(
                      title: "HeySub",
                      subtitle: "heySub",
                    ),
                  ],
                ),
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
              CategoryItem(
                title: "Hey",
                subtitle: "hey",
              ),
            ];

            final favorites = items;

            return FavoriteDividedListView(
              favorites: favorites,
              children: items,
              onFavoritesTap: () => Navigator.pushNamed(
                context,
                "",
                arguments: favorites,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentScreenIndex = useState(1);

    final learnKey = useMemoized(() => GlobalKey<NavigatorState>());

    final screens = [
      _buildTabNavigator(learnKey),
      TrainScreen(),
      CustomScreen(),
    ];

    bool canPopNested() {
      final navigator = learnKey.currentState;
      return navigator?.canPop() ?? false;
    }

    void handlePop() {
      if (canPopNested()) {
        learnKey.currentState?.maybePop();
      } else {
        Navigator.of(context).maybePop();
      }
    }

    final bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentScreenIndex.value,
      backgroundColor: Styles.foregroundColor,
      selectedItemColor: Styles.backgroundColor,
      unselectedItemColor: Styles.colorIgnored,
      onTap: (index) {
        currentScreenIndex.value = index;
      },
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

    return PopScope(
      canPop: !!canPopNested(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && canPopNested()) {
          learnKey.currentState?.maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          leading: canPopNested()
              ? IconButton(
                  onPressed: handlePop,
                  icon: Icon(Symbols.arrow_back),
                )
              : null,
          title: Text(
            Values.applicationTitle,
          ),
          backgroundColor: Styles.foregroundColor,
          foregroundColor: Styles.backgroundColor,
        ),
        // Replace with IndexedStack for screen state preservation
        body: screens[currentScreenIndex.value],
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
