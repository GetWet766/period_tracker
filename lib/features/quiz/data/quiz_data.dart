class QuizQuestionModel {
  const QuizQuestionModel({
    required this.id,
    required this.type,
    required this.question,
    this.options = const [],
  });

  final String id;
  final QuizQuestionType type;
  final String question;
  final List<String> options;
}

enum QuizQuestionType {
  name,
  date,
  datePeriod,
  days,
  weight,
  height,
  option,
  multiOption,
}

const List<QuizQuestionModel> quizQuestions = [
  QuizQuestionModel(
    id: 'name',
    question: 'Как Вас зовут?',
    type: QuizQuestionType.name,
  ),
  QuizQuestionModel(
    id: 'birth_date',
    question: 'Ваша дата рождения',
    type: QuizQuestionType.date,
  ),
  QuizQuestionModel(
    id: 'weight',
    question: 'Укажите Ваш вес',
    type: QuizQuestionType.weight,
  ),
  QuizQuestionModel(
    id: 'height',
    question: 'Укажите Ваш рост',
    type: QuizQuestionType.height,
  ),
  QuizQuestionModel(
    id: 'period_avg_length',
    question: 'Как долго обычно длятся Ваши месячные?',
    type: QuizQuestionType.days,
  ),
  QuizQuestionModel(
    id: 'cycle_avg_length',
    question: 'Как долго обычно длится Ваш цикл?',
    type: QuizQuestionType.days,
  ),
  QuizQuestionModel(
    id: 'last_period',
    question: 'Когда были последние месячные?',
    type: QuizQuestionType.datePeriod,
  ),
  // QuizQuestionModel(
  //   id: 'cycle_length',
  //   question: 'Какова обычная длина вашего цикла?',
  //   options: [
  //     'Менее 21 дня',
  //     '21-25 дней',
  //     '26-30 дней',
  //     '31-35 дней',
  //     'Более 35 дней',
  //     'Не знаю',
  //   ],
  //   type: QuizQuestionType.days,
  // ),
  // QuizQuestionModel(
  //   id: 'period_duration',
  //   question: 'Сколько обычно длится менструация?',
  //   options: [
  //     '1-3 дня',
  //     '4-5 дней',
  //     '6-7 дней',
  //     'Более 7 дней',
  //     'По-разному',
  //   ],
  //   type: QuizQuestionType.days,
  // ),
  // QuizQuestionModel(
  //   id: 'symptoms',
  //   question: 'Какие симптомы вы обычно испытываете?',
  //   options: [
  //     'Боли внизу живота',
  //     'Головные боли',
  //     'Перепады настроения',
  //     'Усталость',
  //     'Вздутие живота',
  //     'Болезненность груди',
  //     'Нет выраженных симптомов',
  //   ],
  //   type: QuizQuestionType.multiOption,
  // ),
  // QuizQuestionModel(
  //   id: 'goal',
  //   question: 'Какова ваша основная цель?',
  //   options: [
  //     'Отслеживать цикл',
  //     'Планировать беременность',
  //     'Избегать беременности',
  //     'Следить за здоровьем',
  //   ],
  //   type: QuizQuestionType.multiOption,
  // ),
  // QuizQuestionModel(
  //   id: 'medications',
  //   question: 'Принимаете ли вы какие-либо препараты?',
  //   options: [
  //     'Не принимаю',
  //     'Оральные контрацептивы',
  //     'Гормональные препараты',
  //     'Витамины/БАДы',
  //     'Обезболивающие при менструации',
  //     'Другое',
  //   ],
  //   type: QuizQuestionType.multiOption,
  // ),
];
