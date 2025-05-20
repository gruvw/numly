import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/navigation/router.dart";

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO eager initialization of providers to avoid loading data on first builds

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Values.applicationTitle,
      theme: ThemeData(
        fontFamily: Styles.fontFamily,
        scaffoldBackgroundColor: Styles.backgroundColor,
        primaryColor: Styles.foregroundColor,
      ),
      routerConfig: router,
    );
  }
}
