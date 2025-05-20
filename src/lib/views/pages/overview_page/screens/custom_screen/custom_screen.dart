import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/preferences/providers.dart";

class CustomScreen extends ConsumerWidget {
  const CustomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingLength =
        ref.watch(preferenceTrainingLengthProvider).valueOrNull;

    final highScoreText =
        trainingLength == null ? "LOADING" : trainingLength.toString();

    return Center(
      child: InkWell(
        child: Text("Custom - $highScoreText"),
        onTap: () {
          if (trainingLength != null) {
            ref
                .read(preferenceTrainingLengthProvider.notifier)
                .set(trainingLength + 1);
          }
        },
      ),
    );
  }
}
