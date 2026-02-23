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
  String get nav_home => 'Главная';

  @override
  String get nav_calendar => 'Календарь';

  @override
  String get nav_care => 'Уход';

  @override
  String get articles => 'Статьи';

  @override
  String get recorded_data => 'Записанные данные';

  @override
  String get add_record => 'Добавить запись';

  @override
  String get cycle_day => 'День цикла';

  @override
  String cycle_day_n(String day) {
    return '$day-й день';
  }

  @override
  String get cycle_phase => 'Фаза цикла';

  @override
  String get pregnancy_probability => 'Вероятность беременности';

  @override
  String get intensity => 'Интенсивность';

  @override
  String get mood => 'Настроение';

  @override
  String get symptoms => 'Симптомы';

  @override
  String get notes => 'Заметки';

  @override
  String get prob_very_low => 'Очень низкая';

  @override
  String get prob_low => 'Низкая';

  @override
  String get prob_medium => 'Средняя';

  @override
  String get prob_high => 'Высокая';

  @override
  String get period_ended => 'Закончились';

  @override
  String get period_started => 'Начались';

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
  String calendarDayInfo(String date, String isToday) {
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

  @override
  String get today_is_period_day => 'Сегодня день месячных';

  @override
  String period_day_number(num day) {
    String _temp0 = intl.Intl.pluralLogic(
      day,
      locale: localeName,
      other: '$day дней',
      few: '$day дня',
      one: '$day день',
      zero: '$day день',
    );
    return '$_temp0';
  }

  @override
  String get days_until_period_top => 'До месячных осталось';

  @override
  String get no_info => 'Нет информации';

  @override
  String get how_do_you_feel_today => 'Как Вы себя чувствуете сегодня?';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отменить';

  @override
  String get edit => 'Изменить';

  @override
  String get delete => 'Удалить';

  @override
  String get mood_happy => 'Счастливое';

  @override
  String get mood_sad => 'Грустное';

  @override
  String get mood_anxious => 'Тревожное';

  @override
  String get mood_calm => 'Спокойное';

  @override
  String get mood_irritable => 'Раздражительное';

  @override
  String get mood_energetic => 'Энергичное';

  @override
  String get mood_fatigue => 'Усталое';

  @override
  String get mood_apathetic => 'Апатичное';

  @override
  String get mood_sensitive => 'Чувствительное';

  @override
  String get mood_confused => 'Растерянное';

  @override
  String get mood_focused => 'Сосредоточенное';

  @override
  String get mood_in_love => 'Влюбленное';

  @override
  String get mood_angry => 'Злое';

  @override
  String get mood_inspired => 'Вдохновленное';

  @override
  String get cat_body => 'Тело';

  @override
  String get cat_gi => 'Желудочно-кишечный тракт';

  @override
  String get cat_mental => 'Психика и ментальное состояние';

  @override
  String get cat_discharge => 'Выделения (кроме менструальных)';

  @override
  String get cat_other => 'Другое';

  @override
  String get symp_headache => 'Головная боль';

  @override
  String get symp_back_pain => 'Боль в спине';

  @override
  String get symp_cramps => 'Спазмы';

  @override
  String get symp_breast_tenderness => 'Чувствительность груди';

  @override
  String get symp_bloating => 'Вздутие';

  @override
  String get symp_edema => 'Отеки';

  @override
  String get symp_fatigue => 'Усталость';

  @override
  String get symp_joint_pain => 'Боль в суставах';

  @override
  String get symp_muscle_pain => 'Боль в мышцах';

  @override
  String get symp_chills => 'Озноб';

  @override
  String get symp_hot_flashes => 'Приливы жара';

  @override
  String get symp_nausea => 'Тошнота';

  @override
  String get symp_dizziness => 'Головокружение';

  @override
  String get symp_acne => 'Акне';

  @override
  String get symp_oily_skin => 'Жирная кожа';

  @override
  String get symp_dry_skin => 'Сухая кожа';

  @override
  String get symp_increased_appetite => 'Повышенный аппетит';

  @override
  String get symp_loss_of_appetite => 'Потеря аппетита';

  @override
  String get symp_sweet_cravings => 'Тяга к сладкому';

  @override
  String get symp_salty_cravings => 'Тяга к соленому';

  @override
  String get symp_carb_cravings => 'Тяга к углеводам';

  @override
  String get symp_heartburn => 'Изжога';

  @override
  String get symp_gas => 'Газы';

  @override
  String get symp_constipation => 'Запор';

  @override
  String get symp_diarrhea => 'Диарея';

  @override
  String get symp_insomnia => 'Бессонница';

  @override
  String get symp_drowsiness => 'Сонливость';

  @override
  String get symp_vivid_dreams => 'Яркие сны';

  @override
  String get symp_hard_prosek => 'Трудно просыпаться';

  @override
  String get symp_distraction => 'Рассеянность';

  @override
  String get symp_brain_fog => 'Затуманенность сознания';

  @override
  String get symp_stress => 'Стресс';

  @override
  String get symp_tearfulness => 'Плаксивость';

  @override
  String get symp_panic_attack => 'Паническая атака';

  @override
  String get symp_mood_swings => 'Перепады настроения';

  @override
  String get symp_ocd => 'Обострение ОКР';

  @override
  String get symp_high_libido => 'Повышенное либидо';

  @override
  String get symp_low_libido => 'Пониженное либидо';

  @override
  String get symp_clear => 'Прозрачные';

  @override
  String get symp_white => 'Белые';

  @override
  String get symp_sticky => 'Липкие';

  @override
  String get symp_dryness => 'Сухость';

  @override
  String get symp_cream => 'Крем';

  @override
  String get symp_egg_white => 'Яичный белок';

  @override
  String get symp_yellowish => 'Желтоватые';

  @override
  String get symp_thick => 'Густые';

  @override
  String get symp_cold => 'Простуда';

  @override
  String get symp_fever => 'Температура';

  @override
  String get symp_allergy => 'Аллергия';

  @override
  String get symp_pills => 'Прием таблеток';

  @override
  String get symp_doctor => 'Визит к врачу';

  @override
  String get symp_workout => 'Тренировка';

  @override
  String get flow_spotting => 'Мажущие';

  @override
  String get flow_low => 'Скудные';

  @override
  String get flow_medium => 'Умеренные';

  @override
  String get flow_heavy => 'Обильные';

  @override
  String get flow_sticky => 'Вязкие';

  @override
  String get add_notes_hint => 'Добавьте заметки о вашем дне...';
}
