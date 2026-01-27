import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/linear_progress_bar.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/quiz/data/quiz_data.dart';
import 'package:period_tracker/features/quiz/presentation/cubit/quiz_cubit.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentStep = 0;
  late final LocalStorageService _storage;
  late final QuizCubit _quizCubit;

  // Answers storage
  final Map<String, dynamic> _answers = {};
  final Map<int, Set<int>> _selectedOptions = {};
  final Map<int, DateTime?> _selectedDates = {};
  final Map<int, TextEditingController> _textControllers = {};
  final Map<int, TextEditingController> _numberControllers = {};

  QuizQuestionModel get _currentQuestion => quizQuestions[_currentStep];
  double get _progress => (_currentStep + 1) / quizQuestions.length;
  bool get _isLastStep => _currentStep == quizQuestions.length - 1;

  @override
  void initState() {
    super.initState();
    _storage = sl<LocalStorageService>();
    _quizCubit = sl<QuizCubit>();
    _initializeControllers();
    _loadPreviousAnswers();
  }

  @override
  void dispose() {
    _quizCubit.close();
    // Dispose all text controllers
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    for (final controller in _numberControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    // Initialize controllers for all questions
    for (var i = 0; i < quizQuestions.length; i++) {
      final question = quizQuestions[i];
      if (_isTextQuestion(question)) {
        _textControllers[i] = TextEditingController();
        // Add listener to update button state
        _textControllers[i]!.addListener(() {
          if (mounted) setState(() {});
        });
      } else if (_isNumberQuestion(question)) {
        _numberControllers[i] = TextEditingController();
        // Add listener to update button state
        _numberControllers[i]!.addListener(() {
          if (mounted) setState(() {});
        });
      }
    }
  }

  void _loadPreviousAnswers() {
    final savedAnswers = _storage.getQuizAnswers();
    _answers.addAll(savedAnswers);

    for (var i = 0; i < quizQuestions.length; i++) {
      final question = quizQuestions[i];
      final savedAnswer = savedAnswers[question.id];

      if (savedAnswer == null) continue;

      if (_isDateQuestion(question)) {
        _selectedDates[i] = DateTime.tryParse(savedAnswer as String);
      } else if (_isTextQuestion(question)) {
        _textControllers[i]?.text = savedAnswer as String? ?? '';
      } else if (_isNumberQuestion(question)) {
        _numberControllers[i]?.text = savedAnswer?.toString() ?? '';
      } else if (savedAnswer is List) {
        _selectedOptions[i] = {};
        for (final index in savedAnswer) {
          if (index is int) _selectedOptions[i]!.add(index);
        }
      }
    }
    setState(() {});
  }

  bool _isDateQuestion(QuizQuestionModel question) {
    return question.type == QuizQuestionType.date ||
        question.type == QuizQuestionType.datePeriod;
  }

  bool _isTextQuestion(QuizQuestionModel question) {
    return question.type == QuizQuestionType.name;
  }

  bool _isNumberQuestion(QuizQuestionModel question) {
    return question.type == QuizQuestionType.weight ||
        question.type == QuizQuestionType.height ||
        question.type == QuizQuestionType.days;
  }

  bool _canContinue() {
    final question = _currentQuestion;

    if (_isDateQuestion(question)) {
      return _selectedDates[_currentStep] != null;
    }
    if (_isTextQuestion(question)) {
      return _textControllers[_currentStep]?.text.isNotEmpty ?? false;
    }
    if (_isNumberQuestion(question)) {
      return _numberControllers[_currentStep]?.text.isNotEmpty ?? false;
    }
    return _selectedOptions[_currentStep]?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          TrackerAppBar(
            title: Text(
              'Шаг ${_currentStep + 1} из ${quizQuestions.length}',
            ),
            backgroundColor: colorScheme.surfaceContainerLow,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress bar
                  Hero(
                    tag: 'quizProgressIndicator',
                    child: ExpressiveProgressIndicator(
                      height: 14,
                      strokeWidth: 8,
                      value: _progress,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Question title
                  Text(
                    _currentQuestion.question,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Subtitle for multi-option
                  if (_currentQuestion.type ==
                      QuizQuestionType.multiOption) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Можно выбрать несколько вариантов',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Question content
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildQuestionContent(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Navigation buttons
                  Row(
                    children: [
                      if (_currentStep > 0) ...[
                        OutlinedButton(
                          onPressed: _previousStep,
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(56, 56),
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: FilledButton(
                          onPressed: _canContinue() ? _nextStep : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                          ),
                          child: Text(
                            _isLastStep ? 'Завершить' : 'Продолжить',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent() {
    if (_isDateQuestion(_currentQuestion)) {
      return _buildDatePicker();
    } else if (_isTextQuestion(_currentQuestion)) {
      return _buildTextInput();
    } else if (_isNumberQuestion(_currentQuestion)) {
      return _buildNumberInput();
    } else {
      return _buildOptions();
    }
  }

  Widget _buildTextInput() {
    final colorScheme = ColorScheme.of(context);

    return TextField(
      controller: _textControllers[_currentStep],
      decoration: InputDecoration(
        hintText: 'Введите ваше имя',
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNumberInput() {
    final colorScheme = ColorScheme.of(context);

    var hint = 'Введите значение';
    var suffix = '';

    if (_currentQuestion.type == QuizQuestionType.weight) {
      hint = 'Введите вес';
      suffix = 'кг';
    } else if (_currentQuestion.type == QuizQuestionType.height) {
      hint = 'Введите рост';
      suffix = 'см';
    } else if (_currentQuestion.type == QuizQuestionType.days) {
      hint = 'Введите количество дней';
      suffix = 'дней';
    }

    return TextField(
      controller: _numberControllers[_currentStep],
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffix,
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildDatePicker() {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _selectDate,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedDates[_currentStep] != null
                          ? _formatDate(_selectedDates[_currentStep]!)
                          : 'Выберите дату',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Нажмите, чтобы выбрать',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDates[_currentStep] ?? now,
      firstDate: _currentQuestion.type == QuizQuestionType.date
          ? DateTime(1900)
          : now.subtract(const Duration(days: 60)),
      lastDate: now,
    );
    if (date != null) {
      setState(() => _selectedDates[_currentStep] = date);
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  Widget _buildOptions() {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Column(
      spacing: 8,
      children: [
        for (
          int optionIndex = 0;
          optionIndex < _currentQuestion.options.length;
          optionIndex++
        )
          Material(
            color:
                _selectedOptions[_currentStep]?.contains(optionIndex) ?? false
                ? colorScheme.primaryContainer
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => _toggleOption(optionIndex),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _currentQuestion.options[optionIndex],
                        style: textTheme.bodyLarge?.copyWith(
                          color:
                              _selectedOptions[_currentStep]?.contains(
                                    optionIndex,
                                  ) ??
                                  false
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurface,
                          fontWeight:
                              _selectedOptions[_currentStep]?.contains(
                                    optionIndex,
                                  ) ??
                                  false
                              ? FontWeight.w600
                              : null,
                        ),
                      ),
                    ),
                    if (_selectedOptions[_currentStep]?.contains(optionIndex) ??
                        false)
                      Icon(
                        Icons.check_circle,
                        color: colorScheme.onPrimaryContainer,
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _toggleOption(int optionIndex) {
    setState(() {
      _selectedOptions[_currentStep] ??= {};

      if (_currentQuestion.type == QuizQuestionType.multiOption) {
        if (_selectedOptions[_currentStep]!.contains(optionIndex)) {
          _selectedOptions[_currentStep]!.remove(optionIndex);
        } else {
          _selectedOptions[_currentStep]!.add(optionIndex);
        }
      } else {
        _selectedOptions[_currentStep]!
          ..clear()
          ..add(optionIndex);
      }
    });
  }

  Future<void> _nextStep() async {
    await _saveCurrentAnswer();

    if (_isLastStep) {
      await _completeQuiz();
    } else {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _saveCurrentAnswer() async {
    final question = _currentQuestion;
    dynamic answer;

    if (_isDateQuestion(question)) {
      answer = _selectedDates[_currentStep]?.toIso8601String();
    } else if (_isTextQuestion(question)) {
      answer = _textControllers[_currentStep]?.text;
    } else if (_isNumberQuestion(question)) {
      final text = _numberControllers[_currentStep]?.text;
      answer = text != null && text.isNotEmpty ? int.tryParse(text) : null;
    } else {
      answer = _selectedOptions[_currentStep]?.toList();
    }

    if (answer != null) {
      await _quizCubit.saveAnswer(question.id, answer);
    }
  }

  Future<void> _completeQuiz() async {
    await _initializeMedicationsFromQuiz();
    await _quizCubit.completeQuiz();

    // Mark setup as complete (no longer a new user)
    await _storage.setIsNewUser(value: false);

    if (mounted) {
      context.go('/home');
    }
  }

  Future<void> _initializeMedicationsFromQuiz() async {
    final answers = _storage.getQuizAnswers();
    final medicationsAnswer = answers['medications'] as List?;
    if (medicationsAnswer == null || medicationsAnswer.isEmpty) return;

    final medications = <Map<String, dynamic>>[];
    final medicationsQuestion = quizQuestions
        .where((q) => q.id == 'medications')
        .firstOrNull;

    if (medicationsQuestion == null) return;

    final options = medicationsQuestion.options;

    for (final index in medicationsAnswer) {
      if (index is! int || index >= options.length) continue;
      final option = options[index];

      // Skip "Не принимаю" and "Другое"
      if (option == 'Не принимаю' || option == 'Другое') continue;

      medications.add({
        'id':
            DateTime.now().millisecondsSinceEpoch.toString() + index.toString(),
        'name': option,
        'hour': 9,
        'minute': 0,
        'isEnabled': true,
      });
    }

    if (medications.isNotEmpty) {
      await _storage.saveMedications(medications);
    }
  }
}
