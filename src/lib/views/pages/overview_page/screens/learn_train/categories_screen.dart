import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/components/category_item.dart";

class CategoriesScreen extends ConsumerWidget {
  final Set<Game> allGamesForType;
  final List<Category> categories;

  const CategoriesScreen({
    super.key,
    required this.allGamesForType,
    required this.categories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteGameIds = ref.watch(favoriteGameIdsProvider).valueOrNull;

    final favoriteGamesLengthForType = favoriteGameIds?.nmap(
      (favoriteGameIds) => allGamesForType
          .where((game) => favoriteGameIds.contains(game.id))
          .length,
    );

    final items = categories.map((category) {
      return CategoryItem(category: category);
    }).toList();

    return FavoriteDividedListView(
      favoritesAmount: favoriteGamesLengthForType,
      onFavoritesTap: () {
        context.goRelative(CategoryRoute.favoritesCategory);
      },
      children: items,
    );
  }
}
