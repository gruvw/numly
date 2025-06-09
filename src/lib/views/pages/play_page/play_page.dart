import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:gap/gap.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/test/test.dart";
import "package:numly/state/persistence/kvs/providers.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/pages/play_page/components/input/number_input.dart";
import "package:numly/views/pages/play_page/components/input/virtual_keyboard.dart";
import "package:numly/views/pages/play_page/components/test_area.dart";
import "package:numly/views/pages/play_page/result_screen.dart";

class PlayPage extends HookConsumerWidget {
  /// The id of the game to play.
  /// Assumed to be a valid game id.
  final GameId gameId;

  const PlayPage({
    super.key,
    required this.gameId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(kvsLastGameIdProvider.notifier).set(gameId);
      return null;
    });

    // TODO LATER (custom) games retrieval
    final game = allGames[gameId]!;

    final test = useState<Test?>(null);
    final testStart = useState(DateTime.now());
    final testEnd = useState<DateTime?>(null);
    final answeredQuestionsCount = useState(0);

    // used for endless mode, must have the same length as test
    final nextTest = useState<Test?>(null);

    setTest(int length) {
      test.value = Test(parts: game.parts, length: length);
      nextTest.value = Test(parts: game.parts, length: length);
      testStart.value = DateTime.now();
      answeredQuestionsCount.value = 0;
    }

    final trainingLength = ref.watch(kvsTrainingLengthProvider);
    useEffect(
      () {
        if (test.value != null) {
          return;
        }

        if (learnGames.containsKey(gameId)) {
          setTest(learnTestLength);
          return;
        }

        trainingLength.whenData((trainingLength) {
          setTest(trainingLength);
        });

        return null;
      },
      [trainingLength],
    );

    final endlessMode = ref.watch(kvsEndlessModeProvider).value;

    final numberController = useTextEditingController();

    final testValue = test.value;
    final nextTestValue = nextTest.value;
    final testEndValue = testEnd.value;

    final restartButton = IconButton(
      onPressed: testValue == null || endlessMode == true
          ? null
          : () => setTest(testValue.length),
      tooltip: "Restart",
      icon: Icon(Styles.iconRepeat),
      disabledColor: Styles.colorIgnored,
    );

    final appBar = AppBar(
      title: Text(
        Values.applicationTitle,
      ),
      actions: [
        if (endlessMode != null && testValue != null)
          IconButton(
            onPressed: () {
              if (endlessMode) {
                setTest(testValue.length);
              }
              ref.read(kvsEndlessModeProvider.notifier).set(!endlessMode);
            },
            tooltip: "Endless",
            icon: Icon(
              Styles.iconEndless,
              fill: endlessMode ? 1 : 0,
            ),
          ),
        restartButton,
      ],
      backgroundColor: Styles.foregroundColor,
      foregroundColor: Styles.backgroundColor,
    );

    final testContent = Column(
      children: [
        Text(
          game.title,
          style: TextStyle(color: Styles.foregroundColor),
        ),
        Spacer(),
        if (testValue != null && nextTestValue != null && endlessMode != null)
          TestArea(
            test: testValue,
            nextTest: nextTestValue,
            answeredQuestionsCount: answeredQuestionsCount.value,
            isEndless: endlessMode,
          )
        else
          CircularProgressIndicator(
            color: Styles.foregroundColor,
          ),
        Spacer(),
        NumberInput(numberController: numberController),
        Gap(Styles.standardSpacing * 4),
        VirtualKeyboard(
          numberController: numberController,
          onSubmit: (numberText) {
            if (testValue == null ||
                nextTestValue == null ||
                endlessMode == null) {
              return;
            }

            if (testValue
                .getQuestion(answeredQuestionsCount.value % testValue.length)
                .verify(numberText)
                .correct) {
              if ((answeredQuestionsCount.value % testValue.length) + 1 >=
                  testValue.length) {
                if (!endlessMode) {
                  // test finished
                  testEnd.value = DateTime.now();
                } else {
                  test.value = nextTestValue;
                  nextTest.value = Test(
                    parts: game.parts,
                    length: testValue.length,
                  );
                }
              }
              answeredQuestionsCount.value += 1;
            }
          },
        ),
        Gap(Styles.standardSpacing * 4),
      ],
    );

    final content = testEndValue == null
        ? testContent
        : ResultScreen(
            testDuration: testEndValue.difference(testStart.value),
          );

    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: appBar,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Styles.contentMaxWidth,
          ),
          child: content,
        ),
      ),
    );
  }
}
