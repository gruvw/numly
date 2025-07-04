import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:numly/i18n/l10n/gen-l10n/numly_localizations.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";
import "package:numly/views/navigation/router.dart";

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    // hide splash screen
    FlutterNativeSplash.remove();

    // TODO eager initialization of providers to avoid loading data on first builds

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Values.applicationTitle,
      theme: ThemeData(
        fontFamily: Styles.fontFamily,
        scaffoldBackgroundColor: Styles.colorBackground,
        primaryColor: Styles.colorForeground,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
