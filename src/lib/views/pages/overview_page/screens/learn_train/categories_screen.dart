import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/components/category_item.dart";

class CategoriesScreen extends ConsumerWidget {
  final CategoryRoute categoryRoute;
  final Provider<AsyncValue<Set<String>>> favoriteGameIdsForTypeProvider;
  final List<Category> categories;

  const CategoriesScreen({
    super.key,
    required this.categoryRoute,
    required this.favoriteGameIdsForTypeProvider,
    required this.categories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteGameIdsForType =
        ref.watch(favoriteGameIdsForTypeProvider).valueOrNull;

    final items = categories.map((category) {
      return CategoryItem(
        categoryRoute: categoryRoute,
        category: category,
      );
    }).toList();

    return FavoriteDividedListView(
      favoritesAmount: favoriteGameIdsForType?.nmap(
        (favoriteLevelIds) => favoriteLevelIds.length,
      ),
      onFavoritesTap: () {
        context.go(categoryRoute.favoritesCategoryPath);
      },
      children: items,
    );
  }
}
