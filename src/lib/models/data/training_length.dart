import "package:numly/i18n/l10n/gen-l10n/numly_localizations.dart";
import "package:numly/i18n/utils/hardcoded_string.dart";

enum TrainingLength {
  short(10),
  normal(20),
  long(30),
  extended(50);

  final int length;

  const TrainingLength(this.length);

  String name(AppLocalizations l10n) {
    return switch (this) {
      short => "Short".hardcoded,
      normal => "Normal".hardcoded,
      long => "Long".hardcoded,
      extended => "Extended".hardcoded,
    };
  }
}
