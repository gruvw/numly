import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/models/test/question.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";
import "package:numly/utils/widget_symmetric_padding.dart";
import "package:numly/views/pages/play_page/components/input/number_formatter.dart";

class NumberInput extends StatelessWidget {
  final TextEditingController numberController;
  final SolutionType? solutionType;
  final int mistakeStreak;
  final String? lastSubmittedAnswer;

  const NumberInput({
    super.key,
    required this.numberController,
    required this.solutionType,
    required this.mistakeStreak,
    required this.lastSubmittedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final displayMistake = mistakeStreak > 0;

    final solutionTypeIndicator =
        solutionType?.nmap((solutionType) {
          return Tooltip(
            message: "Solution Type",
            child: Icon(color: Styles.colorForeground, switch (solutionType) {
              SolutionType.decimal => Symbols.speed_1_25,
              SolutionType.fractional => Symbols.timelapse,
              SolutionType.percent => Symbols.percent,
            }),
          );
        }) ??
        SizedBox();

    // display last answer on mistake
    final mistakeIndicator = displayMistake
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
      inputFormatters: [NumberFormatter()],
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
        hintText: displayMistake ? lastSubmittedAnswer : null,
        hintStyle: TextStyle(color: Styles.colorWarning),
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
            paddingWidget: displayMistake
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
