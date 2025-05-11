import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/category_item.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";

class LearnScreen extends StatelessWidget {
  const LearnScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      CategoryItem(
        title: "LEARN",
        subtitle: "hey",
        onTap: () => context.go(
          CategoryRoutes.levels.categoryPath("hey"),
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
    ];

    return FavoriteDividedListView(
      favoritesAmount: 5,
      children: items,
      onFavoritesTap: () {
        context.go(CategoryRoutes.levels.favoritesCategoryPath);
      },
    );
  }
}
