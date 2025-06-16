import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/i18n/utils/hardcoded_string.dart";
import "package:numly/models/test/question.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/components/widget_symmetric_padding.dart";
import "package:numly/views/pages/play_page/components/input/empty_formatter.dart";
import "package:numly/views/pages/play_page/components/input/number_formatter.dart";

class NumberInput extends StatelessWidget {
  final TextEditingController numberController;
  final Question currentQuestion;
  final int mistakeStreak;
  final String? lastSubmittedAnswer;
  final bool displayCorrectAnswer;

  const NumberInput({
    super.key,
    required this.numberController,
    required this.currentQuestion,
    required this.mistakeStreak,
    required this.lastSubmittedAnswer,
    required this.displayCorrectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final didMistake = mistakeStreak > 0;

    final solutionTypeIndicator = Tooltip(
      message: "Solution Type".hardcoded,
      child: Icon(
        color: Styles.colorForeground,
        switch (currentQuestion.solutionType) {
          SolutionType.decimal => Symbols.speed_1_25,
          SolutionType.fractional => Symbols.timelapse,
          SolutionType.percent => Symbols.percent,
        },
      ),
    );

    // display last answer on mistake
    final mistakeIndicator = didMistake
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Symbols.error,
                color: Styles.colorWarning,
              ),
              if (mistakeStreak > 1)
                Text(
                  " ($mistakeStreak)",
                  style: TextStyle(
                    color: Styles.colorWarning,
                  ),
                ),
            ],
          )
        : SizedBox();

    // TODO autofocus, without showing keyboard on phone
    final numberField = TextField(
      controller: numberController,
      showCursor: false,
      enableInteractiveSelection: false,
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      enableSuggestions: false,
      inputFormatters: [
        NumberFormatter(),
        // disallow input if showing correct answer
        if (displayCorrectAnswer) EmptyFormatter(),
      ],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Styles.colorForeground,
        backgroundColor: Styles.colorBackground,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: didMistake
            ? (displayCorrectAnswer
                  ? currentQuestion.solutionText
                  : lastSubmittedAnswer)
            : null,
        hintStyle: TextStyle(
          color: displayCorrectAnswer
              ? Styles.colorSuccess
              : Styles.colorWarning,
        ),
      ),
    );

    final info = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        solutionTypeIndicator,
        mistakeIndicator,
      ],
    );

    return Container(
      color: Styles.colorBackground,
      child: Stack(
        alignment: Alignment.center,
        children: [
          WidgetSymmetricPadding(
            paddingWidget: didMistake
                ? mistakeIndicator
                : solutionTypeIndicator,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: numberField,
            ),
          ),
          info,
        ],
      ),
    );
  }
}
