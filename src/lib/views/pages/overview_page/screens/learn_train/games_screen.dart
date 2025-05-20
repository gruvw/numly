import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/models/game/game.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/favorite_divided_list_view.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class GamesScreen extends ConsumerWidget {
  final String categoryId;
  final List<Category> categories;
  final List<Game> allGames;

  const GamesScreen({
    super.key,
    required this.categoryId,
    required this.categories,
    required this.allGames,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);
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

      games =
          allGames.where((game) => favoriteGameIds.contains(game.id)).toList();

      if (games.isEmpty) {
        return Center(
          child: Text("No favorite games."),
        );
      }
    } else {
      games =
          categories.where((category) => category.id == categoryId).first.games;
    }

    final items = games.map((game) {
      return ListItem(
        title: game.title,
        leading: IconButton(
          onPressed: () {
            db.queries.toggleFavorite(game.id);
          },
          icon: Icon(
            Symbols.star,
            fill: favoriteGameIds?.contains(game.id) == true ? 1 : 0,
          ),
        ),
        subtitle: game.subtitle,
        // TODO trailing
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
