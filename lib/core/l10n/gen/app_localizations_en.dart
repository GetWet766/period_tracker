// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Periodility';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_calendar => 'Calendar';

  @override
  String get nav_care => 'Care';

  @override
  String get articles => 'Articles';

  @override
  String get recorded_data => 'Recorded data';

  @override
  String get add_record => 'Add record';

  @override
  String get cycle_day => 'Cycle day';

  @override
  String cycle_day_n(String day) {
    return '$day-th day';
  }

  @override
  String get cycle_phase => 'Cycle phase';

  @override
  String get pregnancy_probability => 'Pregnancy probability';

  @override
  String get intensity => 'Intensity';

  @override
  String get mood => 'Mood';

  @override
  String get symptoms => 'Symptoms';

  @override
  String get notes => 'Notes';

  @override
  String get prob_very_low => 'Very low';

  @override
  String get prob_low => 'Low';

  @override
  String get prob_medium => 'Medium';

  @override
  String get prob_high => 'High';

  @override
  String get period_ended => 'Finished';

  @override
  String get period_started => 'Started';

  @override
  String articleCategory(String category) {
    String _temp0 = intl.Intl.selectLogic(
      category,
      {
        'other': 'All articles',
        'phases': 'Phases of cycle',
        'care': 'Care of yourself',
        'health': 'Health',
        'tips': 'Tips',
        'additions': 'Additions',
      },
    );
    return '$_temp0';
  }

  @override
  String calendarDayInfo(String date, String isToday) {
    String _temp0 = intl.Intl.selectLogic(
      isToday,
      {
        'true': 'Today: $date',
        'other': '$date',
      },
    );
    return '$_temp0';
  }

  @override
  String get phase_menstruation => 'Menstruation';

  @override
  String get phase_follicular => 'Follicular phase';

  @override
  String get phase_ovulation => 'Ovulation';

  @override
  String get phase_luteal => 'Luteal phase';

  @override
  String until_period(num daysUntil) {
    String _temp0 = intl.Intl.pluralLogic(
      daysUntil,
      locale: localeName,
      other: 'Up to monthly periods',
      one: 'Monthly periods starts tomorrow',
      zero: 'Monthly periods are expected today',
    );
    return '$_temp0';
  }

  @override
  String days_until_period(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days left',
      one: '$days day left',
      zero: '$days days left',
    );
    return '$_temp0';
  }

  @override
  String get today_is_period_day => 'Today is period day';

  @override
  String period_day_number(num day) {
    String _temp0 = intl.Intl.pluralLogic(
      day,
      locale: localeName,
      other: 'Day $day',
      one: 'Day $day',
      zero: 'Day $day',
    );
    return '$_temp0';
  }

  @override
  String get days_until_period_top => 'Days until period';

  @override
  String get no_info => 'No information';

  @override
  String get how_do_you_feel_today => 'How are you feeling today?';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get mood_happy => 'Happy';

  @override
  String get mood_sad => 'Sad';

  @override
  String get mood_anxious => 'Anxious';

  @override
  String get mood_calm => 'Calm';

  @override
  String get mood_irritable => 'Irritable';

  @override
  String get mood_energetic => 'Energetic';

  @override
  String get mood_fatigue => 'Fatigue';

  @override
  String get mood_apathetic => 'Apathetic';

  @override
  String get mood_sensitive => 'Sensitive';

  @override
  String get mood_confused => 'Confused';

  @override
  String get mood_focused => 'Focused';

  @override
  String get mood_in_love => 'In love';

  @override
  String get mood_angry => 'Angry';

  @override
  String get mood_inspired => 'Inspired';

  @override
  String get cat_body => 'Body';

  @override
  String get cat_gi => 'Gastrointestinal';

  @override
  String get cat_mental => 'Psyche and mental';

  @override
  String get cat_discharge => 'Discharge';

  @override
  String get cat_other => 'Other';

  @override
  String get symp_headache => 'Headache';

  @override
  String get symp_back_pain => 'Back pain';

  @override
  String get symp_cramps => 'Cramps';

  @override
  String get symp_breast_tenderness => 'Breast tenderness';

  @override
  String get symp_bloating => 'Bloating';

  @override
  String get symp_edema => 'Edema';

  @override
  String get symp_fatigue => 'Fatigue';

  @override
  String get symp_joint_pain => 'Joint pain';

  @override
  String get symp_muscle_pain => 'Muscle pain';

  @override
  String get symp_chills => 'Chills';

  @override
  String get symp_hot_flashes => 'Hot flashes';

  @override
  String get symp_nausea => 'Nausea';

  @override
  String get symp_dizziness => 'Dizziness';

  @override
  String get symp_acne => 'Acne';

  @override
  String get symp_oily_skin => 'Oily skin';

  @override
  String get symp_dry_skin => 'Dry skin';

  @override
  String get symp_increased_appetite => 'Increased appetite';

  @override
  String get symp_loss_of_appetite => 'Loss of appetite';

  @override
  String get symp_sweet_cravings => 'Sweet cravings';

  @override
  String get symp_salty_cravings => 'Salty cravings';

  @override
  String get symp_carb_cravings => 'Carbohydrate cravings';

  @override
  String get symp_heartburn => 'Heartburn';

  @override
  String get symp_gas => 'Gas';

  @override
  String get symp_constipation => 'Constipation';

  @override
  String get symp_diarrhea => 'Diarrhea';

  @override
  String get symp_insomnia => 'Insomnia';

  @override
  String get symp_drowsiness => 'Drowsiness';

  @override
  String get symp_vivid_dreams => 'Vivid dreams';

  @override
  String get symp_hard_prosek => 'Hard to wake up';

  @override
  String get symp_distraction => 'Distraction';

  @override
  String get symp_brain_fog => 'Brain fog';

  @override
  String get symp_stress => 'Stress';

  @override
  String get symp_tearfulness => 'Tearfulness';

  @override
  String get symp_panic_attack => 'Panic attack';

  @override
  String get symp_mood_swings => 'Mood swings';

  @override
  String get symp_ocd => 'OCD flare-up';

  @override
  String get symp_high_libido => 'High libido';

  @override
  String get symp_low_libido => 'Low libido';

  @override
  String get symp_clear => 'Clear';

  @override
  String get symp_white => 'White';

  @override
  String get symp_sticky => 'Sticky';

  @override
  String get symp_dryness => 'Dryness';

  @override
  String get symp_cream => 'Cream';

  @override
  String get symp_egg_white => 'Egg white';

  @override
  String get symp_yellowish => 'Yellowish';

  @override
  String get symp_thick => 'Thick';

  @override
  String get symp_cold => 'Cold';

  @override
  String get symp_fever => 'Fever';

  @override
  String get symp_allergy => 'Allergy';

  @override
  String get symp_pills => 'Taking pills';

  @override
  String get symp_doctor => 'Doctor visit';

  @override
  String get symp_workout => 'Workout';

  @override
  String get flow_spotting => 'Spotting';

  @override
  String get flow_low => 'Low';

  @override
  String get flow_medium => 'Medium';

  @override
  String get flow_heavy => 'Heavy';

  @override
  String get flow_sticky => 'Sticky';

  @override
  String get add_notes_hint => 'Add notes about your day...';
}
