import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:gap/gap.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/i18n/utils/context_locale.dart";
import "package:numly/models/game/game.dart";
import "package:numly/models/game/learn/learn.dart";
import "package:numly/models/test/test.dart";
import "package:numly/state/persistence/kvs/providers.dart";
import "package:numly/static/styles.dart";
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(kvsLastGameIdProvider.notifier).set(gameId);
      });
      return null;
    }, []);

    // TODO LATER (custom) games retrieval
    final game = allGames[gameId]!;

    final test = useState<Test?>(null);
    final testStart = useState(DateTime.now());
    final testEnd = useState<DateTime?>(null);
    final doneQuestionsCount = useState(0);
    final mistakesCount = useState(0);
    // TODO reset streaks and show answer after x (=2) wrong attempts
    final mistakeStreak = useState(0);
    final lastAnswerSubmitted = useState<String?>(null);
    final failedQuestionsCount = useState(0);

    // used for endless mode, must have the same length as test
    final nextTest = useState<Test?>(null);

    setTest(int length) {
      test.value = Test(parts: game.parts, length: length);
      nextTest.value = Test(parts: game.parts, length: length);
      testStart.value = DateTime.now();
      testEnd.value = null;
      doneQuestionsCount.value = 0;
      mistakesCount.value = 0;
      lastAnswerSubmitted.value = null;
      mistakeStreak.value = 0;
      failedQuestionsCount.value = 0;
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
    final maxMistakeStreak = ref.watch(kvsMaxMistakeStreakProvider).value;

    final endlessMode = ref.watch(kvsEndlessModeProvider).value;

    final numberController = useTextEditingController();

    final testValue = test.value;
    final nextTestValue = nextTest.value;
    final testEndValue = testEnd.value;

    final displayCorrectAnswer =
        maxMistakeStreak != null && mistakeStreak.value >= maxMistakeStreak;

    final restartButton = IconButton(
      onPressed: testValue == null || endlessMode == true
          ? null
          : () => setTest(testValue.length),
      tooltip: context.l10n.restartHint,
      icon: Icon(Styles.iconRepeat),
      disabledColor: Styles.colorIgnored,
    );

    final appBar = AppBar(
      title: Text(context.l10n.applicationTitle),
      actions: [
        if (endlessMode != null && testValue != null && testEndValue == null)
          IconButton(
            onPressed: () {
              if (endlessMode) {
                setTest(testValue.length);
              }
              ref.read(kvsEndlessModeProvider.notifier).set(!endlessMode);
            },
            tooltip: context.l10n.endlessHint,
            icon: Icon(
              Styles.iconEndless,
              fill: endlessMode ? 1 : 0,
            ),
          ),
        restartButton,
      ],
      backgroundColor: Styles.colorForeground,
      foregroundColor: Styles.colorBackground,
    );

    final testContent = Column(
      children: [
        Text(
          game.title(context.l10n),
          style: TextStyle(color: Styles.colorForeground),
        ),
        Spacer(),
        if (testValue != null && nextTestValue != null && endlessMode != null)
          TestArea(
            test: testValue,
            nextTest: nextTestValue,
            doneQuestionsCount: doneQuestionsCount.value,
            isEndless: endlessMode,
          )
        else
          CircularProgressIndicator(
            color: Styles.colorForeground,
          ),
        Spacer(),
        if (testValue != null && doneQuestionsCount.value < testValue.length)
          NumberInput(
            numberController: numberController,
            currentQuestion: testValue.getQuestion(
              doneQuestionsCount.value,
            ),
            mistakeStreak: mistakeStreak.value,
            lastSubmittedAnswer: lastAnswerSubmitted.value,
            displayCorrectAnswer: displayCorrectAnswer,
          ),
        Gap(Styles.standardSpacing * 4),
        VirtualKeyboard(
          numberController: numberController,
          submitOnly: displayCorrectAnswer,
          onSubmit: (numberTextAnswer) {
            if (testValue == null ||
                nextTestValue == null ||
                endlessMode == null) {
              return;
            }

            nextQuestion() {
              doneQuestionsCount.value += 1;
              mistakeStreak.value = 0;

              if (((doneQuestionsCount.value - 1) % testValue.length) + 1 >=
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
            }

            if (numberTextAnswer.isEmpty) {
              if (displayCorrectAnswer) {
                // question was not answered (correct answer displayed)
                failedQuestionsCount.value += 1;
                nextQuestion();
              }
              return;
            }

            lastAnswerSubmitted.value = numberTextAnswer;

            if (testValue
                .getQuestion(doneQuestionsCount.value % testValue.length)
                .verify(numberTextAnswer, context.l10n)
                .correct) {
              nextQuestion();
            } else {
              mistakesCount.value += 1;
              mistakeStreak.value += 1;
            }
          },
        ),
        Gap(Styles.standardSpacing * 4),
      ],
    );

    final content = testEndValue == null || testValue == null
        ? testContent
        : ResultScreen(
            game: game,
            testDuration: testEndValue.difference(testStart.value),
            targetDuration: testValue.targetDuration,
            mistakesCount: mistakesCount.value,
            doneQuestionsCount: doneQuestionsCount.value,
            failedQuestionsCount: failedQuestionsCount.value,
          );

    return Scaffold(
      backgroundColor: Styles.colorBackground,
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
