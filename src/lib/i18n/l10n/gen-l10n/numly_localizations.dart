import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'numly_localizations_en.dart';
import 'numly_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen-l10n/numly_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Numly'**
  String get applicationTitle;

  /// Navigation item header for learning games page
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learnHeader;

  /// Navigation item header for training games page
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get trainHeader;

  /// Navigation item header for custom games page
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customHeader;

  /// Hint for the menu for selecting test length
  ///
  /// In en, this message translates to:
  /// **'Test length'**
  String get testLengthHint;

  /// Hint for the button to replay the last game
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get replayHint;

  /// Hint for the button to restart the current test
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restartHint;

  /// Hint for the button to toggle endless mode
  ///
  /// In en, this message translates to:
  /// **'Endless'**
  String get endlessHint;

  /// Hint for solution type indicator
  ///
  /// In en, this message translates to:
  /// **'Solution Type'**
  String get solutionTypeHint;

  /// Message shown when there is a routing error
  ///
  /// In en, this message translates to:
  /// **'Routing error, redirecting...'**
  String get routingErrorMessage;

  /// Error message when user input is not a valid number
  ///
  /// In en, this message translates to:
  /// **'Your answer is not a valid number.'**
  String get invalidNumberMessage;

  /// Error message when answer is mathematically correct but in the wrong number format
  ///
  /// In en, this message translates to:
  /// **'Mathematically correct but wrong format.'**
  String get wrongFormatMessage;

  /// Message shown when there are no favorite games
  ///
  /// In en, this message translates to:
  /// **'No favorite games.'**
  String get emptyFavoriteGames;

  /// No description provided for @favoritesCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites ({amount})'**
  String favoritesCategoryTitle({required Object amount});

  /// Name for strict mistake streak preference
  ///
  /// In en, this message translates to:
  /// **'Strict'**
  String get mistakeStreakStrict;

  /// Name for retry mistake streak preference
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get mistakeStreakRetry;

  /// Name for resilient mistake streak preference
  ///
  /// In en, this message translates to:
  /// **'Resilient'**
  String get mistakeStreakResilient;

  /// Name for persistent mistake streak preference
  ///
  /// In en, this message translates to:
  /// **'Persistent'**
  String get mistakeStreakPersistent;

  /// Name for unlimited mistake streak preference
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get mistakeStreakUnlimited;

  /// Name for short test training length
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get trainingLengthShort;

  /// Name for normal test training length
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get trainingLengthNormal;

  /// Name for long test training length
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get trainingLengthLong;

  /// Name for extended test training length
  ///
  /// In en, this message translates to:
  /// **'Extended'**
  String get trainingLengthExtended;

  /// Title for integer addition game category
  ///
  /// In en, this message translates to:
  /// **'Integer Addition'**
  String get integerAdditionCategoryTitle;

  /// Subtitle for integer addition category
  ///
  /// In en, this message translates to:
  /// **'Adding integer numbers'**
  String get integerAdditionCategorySubtitle;

  /// Title for small result game
  ///
  /// In en, this message translates to:
  /// **'Small result'**
  String get smallResultGameTitle;

  /// Subtitle for small result game
  ///
  /// In en, this message translates to:
  /// **'Addition with result <10'**
  String get smallResultGameSubtitle;

  /// No description provided for @smallNumbersGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Small numbers'**
  String get smallNumbersGameTitle;

  /// No description provided for @smallNumbersGameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Adding numbers <10'**
  String get smallNumbersGameSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
