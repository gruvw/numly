import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/overview_page/screens/components/category_item.dart";

class FavoriteDividedListView extends StatelessWidget {
  final List<Widget> children;
  final List<Widget> favorites;

  final VoidCallback? onFavoritesTap;

  const FavoriteDividedListView({
    super.key,
    required this.favorites,
    required this.children,
    this.onFavoritesTap,
  });

  Column _itemBuilder(Widget item) {
    final divider = Divider(
      color: Styles.foregroundColor,
    );

    return Column(
      children: [
        item,
        divider,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritesItem = CategoryItem.favorites(
      title: "Favorites (${favorites.length})",
      favorites: favorites,
      onTap: onFavoritesTap,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          if (favorites.isNotEmpty) _itemBuilder(favoritesItem),
          ...children.map(
            (item) => _itemBuilder(item),
          ),
        ],
      ),
    );
  }
}
