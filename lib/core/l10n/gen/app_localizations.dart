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

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Periodility'**
  String get appTitle;

  /// Label for the Home tab in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// Label for the Calendar tab in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get nav_calendar;

  /// Label for the Care tab in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Care'**
  String get nav_care;

  /// Title for the articles section
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// Heading for the section showing user's logs for a specific day
  ///
  /// In en, this message translates to:
  /// **'Recorded data'**
  String get recorded_data;

  /// Button text to open the screen for adding a new daily log
  ///
  /// In en, this message translates to:
  /// **'Add record'**
  String get add_record;

  /// Label for the current day of the menstrual cycle
  ///
  /// In en, this message translates to:
  /// **'Cycle day'**
  String get cycle_day;

  /// Formatted text for cycle day number
  ///
  /// In en, this message translates to:
  /// **'{day}-th day'**
  String cycle_day_n(String day);

  /// Label for the current phase of the cycle
  ///
  /// In en, this message translates to:
  /// **'Cycle phase'**
  String get cycle_phase;

  /// Label for the chance of getting pregnant on a specific day
  ///
  /// In en, this message translates to:
  /// **'Pregnancy probability'**
  String get pregnancy_probability;

  /// Label for period flow intensity
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get intensity;

  /// Label for the user's emotional state
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// Label for physical or mental symptoms recorded
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptoms;

  /// Label for text notes added by the user
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// Pregnancy probability level: Very low
  ///
  /// In en, this message translates to:
  /// **'Very low'**
  String get prob_very_low;

  /// Pregnancy probability level: Low
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get prob_low;

  /// Pregnancy probability level: Medium
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get prob_medium;

  /// Pregnancy probability level: High
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get prob_high;

  /// Button text to mark the end of a period
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get period_ended;

  /// Button text to mark the start of a period
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get period_started;

  /// Article categories filter labels
  ///
  /// In en, this message translates to:
  /// **'{category, select, other{All articles} phases{Phases of cycle} care{Care of yourself} health{Health} tips{Tips} additions{Additions}}'**
  String articleCategory(String category);

  /// Display text for selected date in calendar screen
  ///
  /// In en, this message translates to:
  /// **'{isToday, select, true{Today: {date}} other{{date}}}'**
  String calendarDayInfo(String date, String isToday);

  /// Cycle phase name: Menstruation
  ///
  /// In en, this message translates to:
  /// **'Menstruation'**
  String get phase_menstruation;

  /// Cycle phase name: Follicular phase
  ///
  /// In en, this message translates to:
  /// **'Follicular phase'**
  String get phase_follicular;

  /// Cycle phase name: Ovulation
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get phase_ovulation;

  /// Cycle phase name: Luteal phase
  ///
  /// In en, this message translates to:
  /// **'Luteal phase'**
  String get phase_luteal;

  /// Days remaining until next menstruation
  ///
  /// In en, this message translates to:
  /// **'{daysUntil, plural, =0{Monthly periods are expected today} =1{Monthly periods starts tomorrow} other{Up to monthly periods}}'**
  String until_period(num daysUntil);

  /// Count of days until period for pluralization
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{{days} days left} one{{days} day left} other{{days} days left}}'**
  String days_until_period(num days);

  /// Indication that today is a period day
  ///
  /// In en, this message translates to:
  /// **'Today is period day'**
  String get today_is_period_day;

  /// Number of the current period day
  ///
  /// In en, this message translates to:
  /// **'{day, plural, =0{Day {day}} one{Day {day}} other{Day {day}}}'**
  String period_day_number(num day);

  /// Header text for countdown to period
  ///
  /// In en, this message translates to:
  /// **'Days until period'**
  String get days_until_period_top;

  /// Placeholder when data is missing
  ///
  /// In en, this message translates to:
  /// **'No information'**
  String get no_info;

  /// Greeting/prompt in the log recording screen
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get how_do_you_feel_today;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Edit button label
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Mood: Happy
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get mood_happy;

  /// Mood: Sad
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get mood_sad;

  /// Mood: Anxious
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get mood_anxious;

  /// Mood: Calm
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get mood_calm;

  /// Mood: Irritable
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get mood_irritable;

  /// Mood: Energetic
  ///
  /// In en, this message translates to:
  /// **'Energetic'**
  String get mood_energetic;

  /// Mood: Fatigue
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get mood_fatigue;

  /// Mood: Apathetic
  ///
  /// In en, this message translates to:
  /// **'Apathetic'**
  String get mood_apathetic;

  /// Mood: Sensitive
  ///
  /// In en, this message translates to:
  /// **'Sensitive'**
  String get mood_sensitive;

  /// Mood: Confused
  ///
  /// In en, this message translates to:
  /// **'Confused'**
  String get mood_confused;

  /// Mood: Focused
  ///
  /// In en, this message translates to:
  /// **'Focused'**
  String get mood_focused;

  /// Mood: In love
  ///
  /// In en, this message translates to:
  /// **'In love'**
  String get mood_in_love;

  /// Mood: Angry
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get mood_angry;

  /// Mood: Inspired
  ///
  /// In en, this message translates to:
  /// **'Inspired'**
  String get mood_inspired;

  /// Category for physical symptoms
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get cat_body;

  /// Category for GI-related symptoms
  ///
  /// In en, this message translates to:
  /// **'Gastrointestinal'**
  String get cat_gi;

  /// Category for psychological symptoms
  ///
  /// In en, this message translates to:
  /// **'Psyche and mental'**
  String get cat_mental;

  /// Category for vaginal discharge symptoms
  ///
  /// In en, this message translates to:
  /// **'Discharge'**
  String get cat_discharge;

  /// Category for miscellaneous logs
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get cat_other;

  /// Symptom: Headache
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get symp_headache;

  /// Symptom: Back pain
  ///
  /// In en, this message translates to:
  /// **'Back pain'**
  String get symp_back_pain;

  /// Symptom: Cramps
  ///
  /// In en, this message translates to:
  /// **'Cramps'**
  String get symp_cramps;

  /// Symptom: Breast tenderness
  ///
  /// In en, this message translates to:
  /// **'Breast tenderness'**
  String get symp_breast_tenderness;

  /// Symptom: Bloating
  ///
  /// In en, this message translates to:
  /// **'Bloating'**
  String get symp_bloating;

  /// Symptom: Edema (swelling)
  ///
  /// In en, this message translates to:
  /// **'Edema'**
  String get symp_edema;

  /// Symptom: Fatigue
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get symp_fatigue;

  /// Symptom: Joint pain
  ///
  /// In en, this message translates to:
  /// **'Joint pain'**
  String get symp_joint_pain;

  /// Symptom: Muscle pain
  ///
  /// In en, this message translates to:
  /// **'Muscle pain'**
  String get symp_muscle_pain;

  /// Symptom: Chills
  ///
  /// In en, this message translates to:
  /// **'Chills'**
  String get symp_chills;

  /// Symptom: Hot flashes
  ///
  /// In en, this message translates to:
  /// **'Hot flashes'**
  String get symp_hot_flashes;

  /// Symptom: Nausea
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get symp_nausea;

  /// Symptom: Dizziness
  ///
  /// In en, this message translates to:
  /// **'Dizziness'**
  String get symp_dizziness;

  /// Symptom: Acne
  ///
  /// In en, this message translates to:
  /// **'Acne'**
  String get symp_acne;

  /// Symptom: Oily skin
  ///
  /// In en, this message translates to:
  /// **'Oily skin'**
  String get symp_oily_skin;

  /// Symptom: Dry skin
  ///
  /// In en, this message translates to:
  /// **'Dry skin'**
  String get symp_dry_skin;

  /// Symptom: Increased appetite
  ///
  /// In en, this message translates to:
  /// **'Increased appetite'**
  String get symp_increased_appetite;

  /// Symptom: Loss of appetite
  ///
  /// In en, this message translates to:
  /// **'Loss of appetite'**
  String get symp_loss_of_appetite;

  /// Symptom: Craving sweets
  ///
  /// In en, this message translates to:
  /// **'Sweet cravings'**
  String get symp_sweet_cravings;

  /// Symptom: Craving salty food
  ///
  /// In en, this message translates to:
  /// **'Salty cravings'**
  String get symp_salty_cravings;

  /// Symptom: Craving carbs
  ///
  /// In en, this message translates to:
  /// **'Carbohydrate cravings'**
  String get symp_carb_cravings;

  /// Symptom: Heartburn
  ///
  /// In en, this message translates to:
  /// **'Heartburn'**
  String get symp_heartburn;

  /// Symptom: Gas/Flatulence
  ///
  /// In en, this message translates to:
  /// **'Gas'**
  String get symp_gas;

  /// Symptom: Constipation
  ///
  /// In en, this message translates to:
  /// **'Constipation'**
  String get symp_constipation;

  /// Symptom: Diarrhea
  ///
  /// In en, this message translates to:
  /// **'Diarrhea'**
  String get symp_diarrhea;

  /// Symptom: Insomnia
  ///
  /// In en, this message translates to:
  /// **'Insomnia'**
  String get symp_insomnia;

  /// Symptom: Drowsiness
  ///
  /// In en, this message translates to:
  /// **'Drowsiness'**
  String get symp_drowsiness;

  /// Symptom: Vivid dreams
  ///
  /// In en, this message translates to:
  /// **'Vivid dreams'**
  String get symp_vivid_dreams;

  /// Symptom: Difficulty waking up
  ///
  /// In en, this message translates to:
  /// **'Hard to wake up'**
  String get symp_hard_prosek;

  /// Symptom: Lack of focus
  ///
  /// In en, this message translates to:
  /// **'Distraction'**
  String get symp_distraction;

  /// Symptom: Brain fog
  ///
  /// In en, this message translates to:
  /// **'Brain fog'**
  String get symp_brain_fog;

  /// Symptom: Stress
  ///
  /// In en, this message translates to:
  /// **'Stress'**
  String get symp_stress;

  /// Symptom: Easy to cry
  ///
  /// In en, this message translates to:
  /// **'Tearfulness'**
  String get symp_tearfulness;

  /// Symptom: Panic attack
  ///
  /// In en, this message translates to:
  /// **'Panic attack'**
  String get symp_panic_attack;

  /// Symptom: Mood swings
  ///
  /// In en, this message translates to:
  /// **'Mood swings'**
  String get symp_mood_swings;

  /// Symptom: OCD flare-up
  ///
  /// In en, this message translates to:
  /// **'OCD flare-up'**
  String get symp_ocd;

  /// Symptom: High libido
  ///
  /// In en, this message translates to:
  /// **'High libido'**
  String get symp_high_libido;

  /// Symptom: Low libido
  ///
  /// In en, this message translates to:
  /// **'Low libido'**
  String get symp_low_libido;

  /// Discharge type: Clear
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get symp_clear;

  /// Discharge type: White
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get symp_white;

  /// Discharge type: Sticky
  ///
  /// In en, this message translates to:
  /// **'Sticky'**
  String get symp_sticky;

  /// Sensation: Dryness
  ///
  /// In en, this message translates to:
  /// **'Dryness'**
  String get symp_dryness;

  /// Discharge type: Creamy
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get symp_cream;

  /// Discharge type: Egg white (ovulation)
  ///
  /// In en, this message translates to:
  /// **'Egg white'**
  String get symp_egg_white;

  /// Discharge type: Yellowish
  ///
  /// In en, this message translates to:
  /// **'Yellowish'**
  String get symp_yellowish;

  /// Discharge type: Thick
  ///
  /// In en, this message translates to:
  /// **'Thick'**
  String get symp_thick;

  /// Condition: Cold/Flu symptoms
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get symp_cold;

  /// Condition: High temperature
  ///
  /// In en, this message translates to:
  /// **'Fever'**
  String get symp_fever;

  /// Condition: Allergy
  ///
  /// In en, this message translates to:
  /// **'Allergy'**
  String get symp_allergy;

  /// Action: Medication taken
  ///
  /// In en, this message translates to:
  /// **'Taking pills'**
  String get symp_pills;

  /// Action: Visited a doctor
  ///
  /// In en, this message translates to:
  /// **'Doctor visit'**
  String get symp_doctor;

  /// Action: Physical exercise
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get symp_workout;

  /// Flow intensity: Spotting
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get flow_spotting;

  /// Flow intensity: Low
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get flow_low;

  /// Flow intensity: Medium
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get flow_medium;

  /// Flow intensity: Heavy
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get flow_heavy;

  /// Flow consistency: Sticky
  ///
  /// In en, this message translates to:
  /// **'Sticky'**
  String get flow_sticky;

  /// Hint text for the notes input field
  ///
  /// In en, this message translates to:
  /// **'Add notes about your day...'**
  String get add_notes_hint;
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
