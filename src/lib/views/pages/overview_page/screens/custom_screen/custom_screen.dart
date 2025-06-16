import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/i18n/utils/hardcoded_string.dart";
import "package:numly/state/persistence/kvs/providers.dart";

class CustomScreen extends ConsumerWidget {
  const CustomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingLength = ref.watch(kvsTrainingLengthProvider).value;

    final trainingLengthText = trainingLength == null
        ? "LOADING".hardcoded
        : trainingLength.toString();

    return Center(
      child: InkWell(
        child: Text("Custom - $trainingLengthText".hardcoded),
        onTap: () {
          if (trainingLength != null) {
            ref
                .read(kvsTrainingLengthProvider.notifier)
                .set(trainingLength + 1);
          }
        },
      ),
    );
  }
}
