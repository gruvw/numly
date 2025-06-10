import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/models/test/question.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";
import "package:numly/views/pages/play_page/components/input/number_formatter.dart";

class NumberInput extends StatelessWidget {
  final TextEditingController numberController;
  final SolutionType? solutionType;

  const NumberInput({
    super.key,
    required this.numberController,
    required this.solutionType,
  });

  @override
  Widget build(BuildContext context) {
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
      ],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Styles.foregroundColor,
        backgroundColor: Styles.backgroundColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        prefixIcon: solutionType?.nmap((solutionType) {
          return Tooltip(
            message: "Solution Type",
            child: Icon(
              color: Styles.foregroundColor,
              switch (solutionType) {
                SolutionType.decimal => Symbols.speed_1_25,
                SolutionType.fractional => Symbols.timelapse,
                SolutionType.percent => Symbols.percent,
              },
            ),
          );
        }),
        prefixIconConstraints: BoxConstraints.tightFor(),
      ),
    );

    return Container(
      color: Styles.backgroundColor,
      child: numberField,
    );
  }
}
