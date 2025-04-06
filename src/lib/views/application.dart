import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/navigation/routes.dart";

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Values.applicationTitle,
      theme: ThemeData(
        fontFamily: Styles.fontFamily,
        colorSchemeSeed: Styles.black,
      ),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.initial.name,
    );
  }
}
