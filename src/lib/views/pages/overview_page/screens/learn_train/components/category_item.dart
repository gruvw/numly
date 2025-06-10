import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/state/persistence/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/pages/overview_page/screens/components/list_item.dart";

class CategoryItem extends HookConsumerWidget {
  final Category category;

  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forceShowProgress = useState(false);

    final completedLevelIds = ref.watch(completedLevelIdsProvider).value;

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
                : Styles.colorForeground,
          ),
        );

        if (categoryCompleted) {
          return IconButton(
            onPressed: () => forceShowProgress.value = !forceShowProgress.value,
            icon: forceShowProgress.value
                ? progress
                : Icon(
                    Styles.iconCompleted,
                    color: Styles.colorSuccess,
                  ),
          );
        }

        return progress;
      },
    );

    final trailing = learnCategories.containsKey(category.id)
        ? levelsProgress
        : Icon(Styles.iconNext);

    return ListItem(
      title: category.title,
      subtitle: category.subtitle,
      trailing: trailing,
      onTap: () => context.goRelative(category.id),
    );
  }
}
