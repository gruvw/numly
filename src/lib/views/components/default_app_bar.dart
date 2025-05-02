import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";

PreferredSizeWidget defaultAppBar() {
  return AppBar(
    title: Text(
      Values.applicationTitle,
    ),
    backgroundColor: Styles.foregroundColor,
    foregroundColor: Styles.backgroundColor,
  );
}
