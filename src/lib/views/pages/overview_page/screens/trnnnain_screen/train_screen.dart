import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class TrainScreen extends StatelessWidget {
  const TrainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ListItem(
        title: "TRAIN",
        subtitle: "hey",
      ),
      ListItem(
        title: "Hey",
        subtitle: "hey",
      ),
      ListItem(
        title: "Hey",
        subtitle: "hey",
      ),
    ];

    return FavoriteDividedListView(
      favoritesAmount: 3,
      children: items,
      onFavoritesTap: () {
        context.go(CategoryRoute.trainings.favoritesCategoryPath);
      },
    );
  }
}
