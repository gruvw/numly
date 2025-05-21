import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/learn_train/components/game_item.dart";

class GamesScreen extends ConsumerWidget {
  final String categoryId;
  final Category category;
  final Set<Game> allGamesForType;

  const GamesScreen({
    super.key,
    required this.categoryId,
    required this.category,
    required this.allGamesForType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteGameIds = ref.watch(favoriteGameIdsProvider).valueOrNull;

    late final List<Game> games;
    if (categoryId == CategoryRoute.favoritesCategory) {
      if (favoriteGameIds == null) {
        return Center(
          child: CircularProgressIndicator(
            color: Styles.foregroundColor,
          ),
        );
      }

      games = allGamesForType
          .where((game) => favoriteGameIds.contains(game.id))
          .toList();

      if (games.isEmpty) {
        return Center(
          child: Text("No favorite games."),
        );
      }
    } else {
      games = category.games;
    }

    final items = games.map((game) {
      return GameItem(
        game: game,
      );
    }).toList();

    return FavoriteDividedListView(
      children: items,
    );
  }
}
