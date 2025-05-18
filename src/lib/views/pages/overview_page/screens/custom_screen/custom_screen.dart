import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/state/persistence/preferences/providers.dart";

class CustomScreen extends ConsumerWidget {
  const CustomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingLength = ref.watch(preferenceTrainingLengthProvider);

    final highScoreText = trainingLength.maybeWhen(
      data: (length) => length.toString(),
      orElse: () => "LOADING",
    );

    return Center(
      child: InkWell(
        child: Text("Custom - $highScoreText"),
        onTap: () => trainingLength.whenData((length) {
          ref.read(preferenceTrainingLengthProvider.notifier).set(length + 1);
        }),
      ),
    );
  }
}
