// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'numly_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get applicationTitle => 'Numly';

  @override
  String get learnHeader => 'Apprendre';

  @override
  String get trainHeader => 'Entrainement';

  @override
  String get customHeader => 'Personnalisé';

  @override
  String get testLengthHint => 'Longueur du test';

  @override
  String get replayHint => 'Rejouer';

  @override
  String get restartHint => 'Recommencer';

  @override
  String get endlessHint => 'Sans fin';

  @override
  String get solutionTypeHint => 'Type de solution';

  @override
  String get routingErrorMessage => 'Erreur de navigation, redirection...';

  @override
  String get invalidNumberMessage =>
      'Votre réponse n\'est pas un nombre valide.';

  @override
  String get wrongFormatMessage =>
      'Mathématiquement correct mais format incorrect.';

  @override
  String get emptyFavoriteGames => 'Aucun jeu favori.';

  @override
  String favoritesCategoryTitle({required Object amount}) {
    return 'Favoris ($amount)';
  }

  @override
  String get mistakeStreakStrict => 'Strict';

  @override
  String get mistakeStreakRetry => 'Réessayer';

  @override
  String get mistakeStreakResilient => 'Résilient';

  @override
  String get mistakeStreakPersistent => 'Persistant';

  @override
  String get mistakeStreakUnlimited => 'Illimité';

  @override
  String get trainingLengthShort => 'Court';

  @override
  String get trainingLengthNormal => 'Normal';

  @override
  String get trainingLengthLong => 'Long';

  @override
  String get trainingLengthExtended => 'Étendu';

  @override
  String get integerAdditionCategoryTitle => 'Addition d\'entiers';

  @override
  String get integerAdditionCategorySubtitle =>
      'Additionner des nombres entiers';

  @override
  String get smallResultGameTitle => 'Petit résultat';

  @override
  String get smallResultGameSubtitle => 'Addition avec résultat <10';

  @override
  String get smallNumbersGameTitle => 'Petits nombres';

  @override
  String get smallNumbersGameSubtitle => 'Additionner des nombres <10';
}
