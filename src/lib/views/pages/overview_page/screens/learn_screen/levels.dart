import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class Levels extends ConsumerWidget {
  final String categoryId;

  const Levels({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteLevelIds = ref.watch(favortieLevelIdsProvider).valueOrNull;

    late final List<Game> games;
    if (categoryId == CategoryRoutes.favoritesCategory) {
      if (favoriteLevelIds == null) {
        return Center(
          child: CircularProgressIndicator(
            color: Styles.foregroundColor,
          ),
        );
      }

      games = learnGames
          .where((game) => favoriteLevelIds.contains(game.id))
          .toList();
    } else {
      games = learnCategories
          .where((category) => category.id == categoryId)
          .first
          .games;
    }

    final items = games.map((game) {
      return ListItem(
        title: game.title,
        subtitle: game.subtitle,
        onTap: () {
          // TODO launch game
        },
      );
    }).toList();

    return FavoriteDividedListView(
      children: items,
    );
  }
}
