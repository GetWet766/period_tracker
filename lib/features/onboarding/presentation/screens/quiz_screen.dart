import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/custom_list_tile.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/onboarding/data/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({required this.questionIndex, super.key});

  final int questionIndex;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Set<int> _selectedOptions = {};
  DateTime? _selectedDate;
  late final LocalStorageService _storage;

  QuizQuestion get question => quizQuestions[widget.questionIndex];
  bool get isLastQuestion => widget.questionIndex == quizQuestions.length - 1;
  double get progress => (widget.questionIndex + 1) / quizQuestions.length;
  bool get isDateQuestion => question.type == QuizQuestionType.date;
  bool get canContinue =>
      isDateQuestion ? _selectedDate != null : _selectedOptions.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _storage = sl<LocalStorageService>();
    _loadPreviousAnswer();
  }

  void _loadPreviousAnswer() {
    final answers = _storage.getQuizAnswers();
    final savedAnswer = answers[question.id];
    if (savedAnswer == null) return;

    if (isDateQuestion) {
      _selectedDate = DateTime.tryParse(savedAnswer as String);
    } else if (savedAnswer is List) {
      for (final index in savedAnswer) {
        if (index is int) _selectedOptions.add(index);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          TrackerAppBar(
            title: Text(
              'Вопрос ${widget.questionIndex + 1} из ${quizQuestions.length}',
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              margin: const .only(top: 16),
              padding: const .all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: .circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    question.question,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (question.multiSelect) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Можно выбрать несколько вариантов',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (isDateQuestion)
                    _buildDatePicker(context)
                  else
                    ClipRRect(
                      borderRadius: .circular(16),
                      child: Column(
                        spacing: 2,
                        children: [
                          for (
                            int index = 0;
                            index < question.options.length;
                            index++
                          )
                            _buildOptionTile(
                              context,
                              text: question.options[index],
                              isSelected: _selectedOptions.contains(
                                index,
                              ),
                              onTap: () => _toggleOption(index),
                            ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: canContinue ? _continue : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: Text(
                      isLastQuestion ? 'Завершить' : 'Продолжить',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _selectDate,
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                      _selectedDate != null
                          ? _formatDate(_selectedDate!)
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
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 60)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return CustomListTile(
      backgroundColor: isSelected
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerLow,
      foregroundColor: isSelected
          ? colorScheme.onPrimaryContainer
          : colorScheme.onSurfaceVariant,
      title: Text(
        text,
        style: textTheme.bodyLarge?.copyWith(
          color: isSelected
              ? colorScheme.onPrimaryContainer
              : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w600 : null,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: colorScheme.onPrimaryContainer,
            )
          : null,
      onPressed: onTap,
    );
  }

  void _toggleOption(int index) {
    setState(() {
      if (question.multiSelect) {
        if (_selectedOptions.contains(index)) {
          _selectedOptions.remove(index);
        } else {
          _selectedOptions.add(index);
        }
      } else {
        _selectedOptions
          ..clear()
          ..add(index);
      }
    });
  }

  Future<void> _continue() async {
    await _saveAnswer();
    if (isLastQuestion) {
      await _initializeMedicationsFromQuiz();
      await context.push('/home');
    } else {
      await context.push('/welcome/quiz/${widget.questionIndex + 1}');
    }
  }

  Future<void> _saveAnswer() async {
    final answers = _storage.getQuizAnswers();
    if (isDateQuestion) {
      answers[question.id] = _selectedDate?.toIso8601String();
    } else {
      answers[question.id] = _selectedOptions.toList();
    }
    await _storage.saveQuizAnswers(answers);
  }

  Future<void> _initializeMedicationsFromQuiz() async {
    final answers = _storage.getQuizAnswers();
    final medicationsAnswer = answers['medications'] as List?;
    if (medicationsAnswer == null || medicationsAnswer.isEmpty) return;

    final medications = <Map<String, dynamic>>[];
    final options = quizQuestions
        .firstWhere((q) => q.id == 'medications')
        .options;

    for (final index in medicationsAnswer) {
      if (index is! int || index >= options.length) continue;
      final option = options[index];

      // Пропускаем "Не принимаю" и "Другое"
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
