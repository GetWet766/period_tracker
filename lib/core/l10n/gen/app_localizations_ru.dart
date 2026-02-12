// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Periodility';

  @override
  String articleCategory(String category) {
    String _temp0 = intl.Intl.selectLogic(
      category,
      {
        'other': 'Все статьи',
        'phases': 'Фазы цикла',
        'care': 'Забота о себе',
        'health': 'Здоровье',
        'tips': 'Советы',
        'additions': 'Дополнительно',
      },
    );
    return '$_temp0';
  }

  @override
  String calendarDayInfo(String isToday, String date) {
    String _temp0 = intl.Intl.selectLogic(
      isToday,
      {
        'true': 'Сегодня: $date',
        'other': '$date',
      },
    );
    return '$_temp0';
  }

  @override
  String get phase_menstruation => 'Менструация';

  @override
  String get phase_follicular => 'Фолликулярная фаза';

  @override
  String get phase_ovulation => 'Овуляция';

  @override
  String get phase_luteal => 'Лютеиновая фаза';

  @override
  String until_period(num daysUntil) {
    String _temp0 = intl.Intl.pluralLogic(
      daysUntil,
      locale: localeName,
      other: 'До месячных',
      few: 'До месячных',
      one: 'Завтра начнутся месячные',
      zero: 'Сегодня ожидаются месячные',
    );
    return '$_temp0';
  }

  @override
  String days_until_period(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дней',
      few: '$days дня',
      one: 'Остался $days день',
      zero: 'Осталось $days дней',
    );
    return '$_temp0';
  }
}
