import "package:flutter/material.dart";
import "package:numly/views/pages/overview_page/screens/components/category_item.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
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
}
