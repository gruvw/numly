import "package:flutter/material.dart";
import "package:numly/models/test/test.dart";
import "package:numly/views/pages/play_page/components/question_display.dart";

class TestArea extends StatelessWidget {
  final Test test;
  final Test nextTest;
  final int doneQuestionsCount;
  final bool isEndless;

  const TestArea({
    super.key,
    required this.test,
    required this.nextTest,
    required this.doneQuestionsCount,
    required this.isEndless,
  });

  @override
  Widget build(BuildContext context) {
    final currentQuestionIndex = doneQuestionsCount % test.length;
    final currentQuestion = test.getQuestion(currentQuestionIndex);
    final nextQuestion = currentQuestionIndex + 1 < test.length
        ? test.getQuestion(currentQuestionIndex + 1)
        : (isEndless ? nextTest.getQuestion(0) : null);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$doneQuestionsCount/${isEndless ? "∞" : test.length}"),
            nextQuestion == null
                ? Text("---")
                : QuestionDisplay(question: nextQuestion),
          ],
        ),
        QuestionDisplay(question: currentQuestion),
      ],
    );
  }
}
