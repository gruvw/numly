import "package:flutter/foundation.dart";

abstract class BuildOptions {
  /// Delete and create a fresh DB in debug mode if true
  static const debugEraseDB = bool.fromEnvironment(
        "DEBUG_ERASE_DB",
        defaultValue: false,
      ) &&
      kDebugMode;
}
