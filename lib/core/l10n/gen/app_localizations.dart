// dart format off
// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// Name of the app.
  ///
  /// In en, this message translates to:
  /// **'Periodility'**
  String get appTitle;

  /// Article category
  ///
  /// In en, this message translates to:
  /// **'{category, select, other{All articles} phases{Phases of cycle} care{Care of yourself} health{Health} tips{Tips} additions{Additions}}'**
  String articleCategory(String category);

  /// Info about days in calendar
  ///
  /// In en, this message translates to:
  /// **'{isToday, select, true{Today: {date}} other{{date}}}'**
  String calendarDayInfo(String isToday, String date);

  /// No description provided for @phase_menstruation.
  ///
  /// In en, this message translates to:
  /// **'Menstruation'**
  String get phase_menstruation;

  /// No description provided for @phase_follicular.
  ///
  /// In en, this message translates to:
  /// **'Follicular phase'**
  String get phase_follicular;

  /// No description provided for @phase_ovulation.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get phase_ovulation;

  /// No description provided for @phase_luteal.
  ///
  /// In en, this message translates to:
  /// **'Lucien phase'**
  String get phase_luteal;

  /// No description provided for @until_period.
  ///
  /// In en, this message translates to:
  /// **'{daysUntil, plural, =0{Monthly periods are expected today} =1{Monthly periods starts tomorrow} other{Up to monthly periods}}'**
  String until_period(num daysUntil);

  /// No description provided for @days_until_period.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{{days} days left} one{{days} day left} other{{days} days left}}'**
  String days_until_period(num days);

  /// No description provided for @today_is_period_day.
  ///
  /// In en, this message translates to:
  /// **'Today is period day'**
  String get today_is_period_day;

  /// No description provided for @period_day_number.
  ///
  /// In en, this message translates to:
  /// **'{day, plural, =0{Day {day}} one{Day {day}} other{Day {day}}}'**
  String period_day_number(num day);

  /// No description provided for @days_until_period_top.
  ///
  /// In en, this message translates to:
  /// **'Days until period'**
  String get days_until_period_top;

  /// No description provided for @no_info.
  ///
  /// In en, this message translates to:
  /// **'No information'**
  String get no_info;

  /// No description provided for @how_do_you_feel_today.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get how_do_you_feel_today;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
