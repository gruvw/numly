// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'numly_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get applicationTitle => 'Numly';

  @override
  String get learnHeader => 'Learn';

  @override
  String get trainHeader => 'Train';

  @override
  String get customHeader => 'Custom';

  @override
  String get testLengthHint => 'Test length';

  @override
  String get replayHint => 'Replay';

  @override
  String get restartHint => 'Restart';

  @override
  String get endlessHint => 'Endless';

  @override
  String get solutionTypeHint => 'Solution Type';

  @override
  String get routingErrorMessage => 'Routing error, redirecting...';

  @override
  String get invalidNumberMessage => 'Your answer is not a valid number.';

  @override
  String get wrongFormatMessage => 'Mathematically correct but wrong format.';

  @override
  String get emptyFavoriteGames => 'No favorite games.';

  @override
  String favoritesCategoryTitle({required Object amount}) {
    return 'Favorites ($amount)';
  }

  @override
  String get mistakeStreakStrict => 'Strict';

  @override
  String get mistakeStreakRetry => 'Retry';

  @override
  String get mistakeStreakResilient => 'Resilient';

  @override
  String get mistakeStreakPersistent => 'Persistent';

  @override
  String get mistakeStreakUnlimited => 'Unlimited';

  @override
  String get trainingLengthShort => 'Short';

  @override
  String get trainingLengthNormal => 'Normal';

  @override
  String get trainingLengthLong => 'Long';

  @override
  String get trainingLengthExtended => 'Extended';

  @override
  String get integerAdditionCategoryTitle => 'Integer Addition';

  @override
  String get integerAdditionCategorySubtitle => 'Adding integer numbers';

  @override
  String get smallResultGameTitle => 'Small result';

  @override
  String get smallResultGameSubtitle => 'Addition with result <10';

  @override
  String get smallNumbersGameTitle => 'Small numbers';

  @override
  String get smallNumbersGameSubtitle => 'Adding numbers <10';
}
