import "package:numly/i18n/l10n/gen-l10n/numly_localizations.dart";

enum MaxMistakeStreak {
  strict(1),
  retry(2),
  resilient(3),
  persistent(5),
  unlimited(99999);

  final int amount;

  const MaxMistakeStreak(this.amount);

  String name(AppLocalizations l10n) {
    return switch (this) {
      strict => l10n.mistakeStreakStrict,
      retry => l10n.mistakeStreakRetry,
      resilient => l10n.mistakeStreakResilient,
      persistent => l10n.mistakeStreakPersistent,
      unlimited => l10n.mistakeStreakUnlimited,
    };
  }
}
