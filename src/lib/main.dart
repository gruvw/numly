import "package:flutter/material.dart";
import "package:flutter_web_plugins/flutter_web_plugins.dart";
import "package:numly/views/application.dart";

void main() {
  usePathUrlStrategy();

  runApp(const Application());
}
