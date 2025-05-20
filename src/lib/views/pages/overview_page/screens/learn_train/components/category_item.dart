import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/navigation/routes.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class CategoryItem extends HookConsumerWidget {
  final CategoryRoute categoryRoute;
  final Category category;

  const CategoryItem({
    super.key,
    required this.categoryRoute,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forceShowProgress = useState(false);

    final completedLevelIds = ref.watch(completedLevelIdsProvider).valueOrNull;

    final completedLevelsAmount = completedLevelIds?.nmap(
      (completedLevelIds) => completedLevelIds
          .where((levelId) => levelId.startsWith(category.id))
          .length,
    );

    final levelsProgress = completedLevelsAmount?.nmap(
      (completedLevelsAmount) {
        final categoryCompleted =
            completedLevelsAmount == category.games.length;

        final progress = Text(
          "$completedLevelsAmount/${category.games.length}",
          style: TextStyle(
            fontSize: 14,
            color: categoryCompleted
                ? Styles.colorSuccess
                : Styles.foregroundColor,
          ),
        );

        if (categoryCompleted) {
          return IconButton(
            onPressed: () => forceShowProgress.value = !forceShowProgress.value,
            icon: forceShowProgress.value
                ? progress
                : Icon(
                    Symbols.check_circle,
                    color: Styles.colorSuccess,
                  ),
          );
        }

        return progress;
      },
    );

    final trailing = learnCategoryIds.contains(category.id)
        ? levelsProgress
        : Icon(Symbols.arrow_forward);

    return ListItem(
      title: category.title,
      subtitle: category.subtitle,
      trailing: trailing,
      onTap: () => context.go(
        categoryRoute.categoryPath(category.id),
      ),
    );
  }
}
