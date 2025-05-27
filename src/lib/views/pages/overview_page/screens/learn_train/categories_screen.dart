import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/components/category_item.dart";

class CategoriesScreen extends ConsumerWidget {
  final Map<GameId, Game> gamesForType;
  final Map<CategoryId, Category> categoriesForType;

  const CategoriesScreen({
    super.key,
    required this.gamesForType,
    required this.categoriesForType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteGameIds = ref.watch(favoriteGameIdsProvider).valueOrNull;

    final favoriteGamesForTypeLength = favoriteGameIds?.nmap(
      (favoriteGameIds) => gamesForType.keys
          .where((gameId) => favoriteGameIds.contains(gameId))
          .length,
    );

    final items = categoriesForType.values.map((category) {
      return CategoryItem(category: category);
    }).toList();

    return FavoriteDividedListView(
      favoritesAmount: favoriteGamesForTypeLength,
      onFavoritesTap: () {
        context.goRelative(CategoryRoute.favoritesCategory);
      },
      children: items,
    );
  }
}
