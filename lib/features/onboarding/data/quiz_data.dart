enum QuizQuestionType { options, date }

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.question,
    this.options = const [],
    this.multiSelect = false,
    this.type = QuizQuestionType.options,
  });

  final String id;
  final String question;
  final List<String> options;
  final bool multiSelect;
  final QuizQuestionType type;
}

const List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    id: 'last_period',
    question: 'Когда закончились последние месячные?',
    type: QuizQuestionType.date,
  ),
  QuizQuestion(
    id: 'cycle_length',
    question: 'Какова обычная длина вашего цикла?',
    options: [
      'Менее 21 дня',
      '21-25 дней',
      '26-30 дней',
      '31-35 дней',
      'Более 35 дней',
      'Не знаю',
    ],
  ),
  QuizQuestion(
    id: 'period_duration',
    question: 'Сколько обычно длится менструация?',
    options: [
      '1-3 дня',
      '4-5 дней',
      '6-7 дней',
      'Более 7 дней',
      'По-разному',
    ],
  ),
  QuizQuestion(
    id: 'symptoms',
    question: 'Какие симптомы вы обычно испытываете?',
    options: [
      'Боли внизу живота',
      'Головные боли',
      'Перепады настроения',
      'Усталость',
      'Вздутие живота',
      'Болезненность груди',
      'Нет выраженных симптомов',
    ],
    multiSelect: true,
  ),
  QuizQuestion(
    id: 'goal',
    question: 'Какова ваша основная цель?',
    options: [
      'Отслеживать цикл',
      'Планировать беременность',
      'Избегать беременности',
      'Следить за здоровьем',
    ],
    multiSelect: true,
  ),
  QuizQuestion(
    id: 'medications',
    question: 'Принимаете ли вы какие-либо препараты?',
    options: [
      'Не принимаю',
      'Оральные контрацептивы',
      'Гормональные препараты',
      'Витамины/БАДы',
      'Обезболивающие при менструации',
      'Другое',
    ],
    multiSelect: true,
  ),
];
