import "package:flutter/material.dart";
import "package:numly/views/pages/overview_page/screens/components/category_item.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";

class TrainScreen extends StatelessWidget {
  const TrainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
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
      CategoryItem(
        title: "Hey",
        subtitle: "hey",
      ),
    ];

    return FavoriteDividedListView(
      favorites: items,
      children: items,
    );
  }
}
