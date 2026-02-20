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
  String calendarDayInfo(String isToday, String date) {
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
  String get phase_luteal => 'Lucien phase';

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
}
