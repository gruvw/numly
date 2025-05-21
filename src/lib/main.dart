import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:numly/views/application.dart";

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // preserve the splash screen for initialization
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    ProviderScope(
      child: const Application(),
    ),
  );
}
