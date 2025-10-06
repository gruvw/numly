import "package:numly/i18n/l10n/gen-l10n/numly_localizations.dart";

enum TrainingLength {
  short(10),
  normal(20),
  long(30),
  extended(50);

  final int length;

  const TrainingLength(this.length);

  String name(AppLocalizations l10n) {
    return switch (this) {
      short => l10n.trainingLengthShort,
      normal => l10n.trainingLengthNormal,
      long => l10n.trainingLengthLong,
      extended => l10n.trainingLengthExtended,
    };
  }
}
