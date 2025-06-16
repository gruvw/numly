import "package:numly/i18n/l10n/gen-l10n/numly_localizations.dart";
import "package:numly/i18n/utils/hardcoded_string.dart";

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
      strict => "Strict".hardcoded,
      retry => "Retry".hardcoded,
      resilient => "Resilient".hardcoded,
      persistent => "Persistent".hardcoded,
      unlimited => "Unlimited".hardcoded,
    };
  }
}
