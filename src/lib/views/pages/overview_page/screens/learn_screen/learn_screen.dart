import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class LearnScreen extends ConsumerWidget {
  const LearnScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteLevelIds = ref.watch(favortieLevelIdsProvider).valueOrNull;

    final items = learnCategories.map((category) {
      return ListItem(
        title: category.title,
        subtitle: category.subtitle,
        onTap: () => context.go(
          CategoryRoutes.levels.categoryPath(category.id),
        ),
      );
    }).toList();

    return FavoriteDividedListView(
      favoritesAmount:
          favoriteLevelIds?.nmap((favoriteLevelIds) => favoriteLevelIds.length),
      onFavoritesTap: () {
        context.go(CategoryRoutes.levels.favoritesCategoryPath);
      },
      children: items,
    );
  }
}
