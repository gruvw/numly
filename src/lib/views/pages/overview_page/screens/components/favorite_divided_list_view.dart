import "package:flutter/material.dart";
import "package:numly/i18n/utils/context_locale.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class FavoriteDividedListView extends StatelessWidget {
  final List<Widget> children;
  final int favoritesAmount;

  final VoidCallback? onFavoritesTap;

  const FavoriteDividedListView({
    super.key,
    required this.children,
    int? favoritesAmount,
    this.onFavoritesTap,
  }) : favoritesAmount = favoritesAmount ?? 0;

  Column _itemBuilder(Widget item) {
    final divider = Divider(
      color: Styles.colorForeground,
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
    final favoritesItem = ListItem.favorites(
      title: context.l10n.favoritesCategoryTitle(amount: favoritesAmount),
      onTap: onFavoritesTap,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          if (favoritesAmount > 0) _itemBuilder(favoritesItem),
          ...children.map(
            (item) => _itemBuilder(item),
          ),
        ],
      ),
    );
  }
}
