import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/views/pages/components/input/number_formatter.dart";

class NumberInput extends StatelessWidget {
  final TextEditingController numberController;

  const NumberInput({
    super.key,
    required this.numberController,
  });

  @override
  Widget build(BuildContext context) {
    final numberField = TextField(
      controller: numberController,
      showCursor: false,
      enableInteractiveSelection: false,
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      enableSuggestions: false,
      // inputFormatters: [
      //   NumberFormatter(),
      // ],
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
        contentPadding: EdgeInsets.all(Styles.standardSpacing * 2),
      ),
    );

    return Container(
      color: Styles.backgroundColor,
      child: numberField,
    );
  }
}
