import "package:flutter/material.dart";
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
  }
}
