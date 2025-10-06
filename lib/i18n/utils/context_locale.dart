import "package:flutter/material.dart";
import "package:numly/i18n/l10n/gen-l10n/numly_localizations.dart";

extension ContextLocale on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
