import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/care/data/care_data.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_state.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  @override
  State<CareScreen> createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  late final LocalStorageService _storage;
  List<Medication> _medications = [];
  WaterReminder _waterReminder = const WaterReminder(
    targetGlasses: 8,
    currentGlasses: 0,
  );

  @override
  void initState() {
    super.initState();
    _storage = sl<LocalStorageService>();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadMedications();
    await _loadWaterReminder();
  }

  Future<void> _loadMedications() async {
    final data = _storage.getMedications();
    if (data.isEmpty) return;

    setState(() {
      _medications = data.map((m) {
        return Medication(
          id: m['id'] as String,
          name: m['name'] as String,
          time: TimeOfDay(
            hour: m['hour'] as int,
            minute: m['minute'] as int,
          ),
          isEnabled: m['isEnabled'] as bool? ?? true,
        );
      }).toList();
    });
  }

  Future<void> _loadWaterReminder() async {
    final data = _storage.getWaterReminder();
    if (data == null) return;

    // Сбрасываем счётчик воды в начале нового дня
    final lastUpdate = data['lastUpdate'] as String?;
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';
    var currentGlasses = data['currentGlasses'] as int? ?? 0;

    if (lastUpdate != todayStr) {
      currentGlasses = 0;
    }

    setState(() {
      _waterReminder = WaterReminder(
        targetGlasses: data['targetGlasses'] as int? ?? 8,
        currentGlasses: currentGlasses,
        isEnabled: data['isEnabled'] as bool? ?? true,
      );
    });

    // Сохраняем обновлённые данные
    if (lastUpdate != todayStr) {
      await _saveWaterReminder();
    }
  }

  Future<void> _saveMedications() async {
    final data = _medications.map((m) {
      return {
        'id': m.id,
        'name': m.name,
        'hour': m.time.hour,
        'minute': m.time.minute,
        'isEnabled': m.isEnabled,
      };
    }).toList();
    await _storage.saveMedications(data);
  }

  Future<void> _saveWaterReminder() async {
    final today = DateTime.now();
    await _storage.saveWaterReminder({
      'targetGlasses': _waterReminder.targetGlasses,
      'currentGlasses': _waterReminder.currentGlasses,
      'isEnabled': _waterReminder.isEnabled,
      'lastUpdate': '${today.year}-${today.month}-${today.day}',
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(title: Text('Уход')),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildTodaySymptomsSection(context),
              const SizedBox(height: 16),
              _buildWaterSection(context),
              const SizedBox(height: 16),
              _buildMedicationsSection(context),
              const SizedBox(height: 16),
              _buildReliefSection(context),
              const SizedBox(height: 16),
              _buildCategoriesSection(context),
              const SizedBox(height: 16),
              _buildArticlesLink(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySymptomsSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return BlocBuilder<CycleCubit, CycleState>(
      builder: (context, state) {
        final todayLog = state.maybeWhen(
          loaded: _getTodayLog,
          orElse: () => null,
        );

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Сегодняшнее самочувствие',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          todayLog != null
                              ? _getSymptomsText(todayLog)
                              : 'Не записано',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (todayLog != null && todayLog.symptoms.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: todayLog.symptoms.map((symptom) {
                    return Chip(
                      label: Text(symptom),
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _showSymptomsDialog(context, todayLog),
                icon: Icon(todayLog != null ? Icons.edit : Icons.add),
                label: Text(
                  todayLog != null ? 'Изменить' : 'Записать самочувствие',
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getSymptomsText(CycleLogEntity log) {
    final parts = <String>[];
    if (log.flowLevel != null) {
      parts.add(log.flowLevel!.displayName);
    }
    if (log.symptoms.isNotEmpty) {
      parts.add('${log.symptoms.length} симптом(ов)');
    }
    return parts.isEmpty ? 'Записано' : parts.join(', ');
  }

  CycleLogEntity? _getTodayLog(List<CycleLogEntity> logs) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    for (final log in logs) {
      final logDate = DateTime(log.date.year, log.date.month, log.date.day);
      if (logDate == normalizedToday) {
        return log;
      }
    }
    return null;
  }

  Future<void> _showSymptomsDialog(
    BuildContext context,
    CycleLogEntity? existingLog,
  ) async {
    final symptoms = List<String>.from(existingLog?.symptoms ?? []);
    var selectedFlow = existingLog?.flowLevel;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Как Вы себя чувствуете?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text('Интенсивность:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: FlowLevel.values.map((flow) {
                      return ChoiceChip(
                        label: Text(flow.displayName),
                        selected: selectedFlow == flow,
                        onSelected: (selected) {
                          setModalState(() {
                            selectedFlow = selected ? flow : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('Симптомы:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        [
                          'Спазмы',
                          'Головная боль',
                          'Усталость',
                          'Вздутие',
                          'Перепады настроения',
                          'Боль в спине',
                        ].map((symptom) {
                          return FilterChip(
                            label: Text(symptom),
                            selected: symptoms.contains(symptom),
                            onSelected: (selected) {
                              setModalState(() {
                                if (selected) {
                                  symptoms.add(symptom);
                                } else {
                                  symptoms.remove(symptom);
                                }
                              });
                            },
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _saveSymptoms(existingLog?.id, selectedFlow, symptoms);
                    },
                    child: const Text('Сохранить'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveSymptoms(
    String? existingId,
    FlowLevel? flow,
    List<String> symptoms,
  ) async {
    final cycleCubit = context.read<CycleCubit>();

    if (existingId != null) {
      await cycleCubit.updateLog(
        id: existingId,
        flowLevel: flow,
        symptoms: symptoms.isNotEmpty ? symptoms : null,
      );
    } else {
      await cycleCubit.createLog(
        date: DateTime.now(),
        flowLevel: flow,
        symptoms: symptoms.isNotEmpty ? symptoms : null,
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные сохранены')),
      );
    }
  }

  Widget _buildWaterSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.water_drop, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вода',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_waterReminder.currentGlasses} из '
                      '${_waterReminder.targetGlasses} стаканов',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _waterReminder.isEnabled,
                onChanged: (value) {
                  setState(() {
                    _waterReminder = _waterReminder.copyWith(isEnabled: value);
                  });
                  _saveWaterReminder();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _waterReminder.currentGlasses / _waterReminder.targetGlasses,
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _waterReminder.currentGlasses > 0
                      ? () {
                          setState(() {
                            _waterReminder = _waterReminder.copyWith(
                              currentGlasses: _waterReminder.currentGlasses - 1,
                            );
                          });
                          _saveWaterReminder();
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                  label: const Text('Убрать'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _waterReminder = _waterReminder.copyWith(
                        currentGlasses: _waterReminder.currentGlasses + 1,
                      );
                    });
                    _saveWaterReminder();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationsSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SectionContainer(
        title: 'Напоминания о препаратах',
        child: Column(
          children: [
            ..._medications.map((med) => _buildMedicationTile(context, med)),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _addMedication,
              icon: const Icon(Icons.add),
              label: const Text('Добавить препарат'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationTile(BuildContext context, Medication medication) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.medication,
              color: colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.name,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Напоминание в ${_formatTime(medication.time)}',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: medication.isEnabled,
            onChanged: (value) => _toggleMedication(medication.id, value),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMedicationOptions(medication),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SectionContainer(
        title: 'Советы по уходу',
        child: Column(
          children: careCategories.map((category) {
            return _buildCategoryCard(context, category);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildReliefSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SectionContainer(
        title: 'Облегчение менструации',
        child: Column(
          children: reliefInstructions.map((instruction) {
            return _buildReliefCard(context, instruction);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildReliefCard(BuildContext context, ReliefInstruction instruction) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            instruction.icon,
            color: colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        title: Text(
          instruction.title,
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          instruction.description,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...instruction.steps.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(entry.value)),
                      ],
                    ),
                  );
                }),
                if (instruction.videoUrl != null) ...[
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Открытие видео в разработке'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_circle_outline),
                    label: const Text('Смотреть видео'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesLink(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/learn'),
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
                  Icons.article,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Полезные статьи',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Узнайте больше о цикле и здоровье',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CareCategory category) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: category.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(category.icon, color: category.color, size: 20),
        ),
        title: Text(
          category.title,
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        children: category.tips.map((tip) {
          return ListTile(
            title: Text(tip.title, style: textTheme.bodyMedium),
            subtitle: Text(
              tip.description,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _toggleMedication(String id, bool value) {
    setState(() {
      _medications = _medications.map((med) {
        if (med.id == id) {
          return med.copyWith(isEnabled: value);
        }
        return med;
      }).toList();
    });
    _saveMedications();
  }

  void _addMedication() {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => _AddMedicationSheet(
          onAdd: (name, time) {
            setState(() {
              _medications.add(
                Medication(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  time: time,
                ),
              );
            });
            _saveMedications();
          },
        ),
      ),
    );
  }

  void _showMedicationOptions(Medication medication) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Редактировать'),
                onTap: () {
                  Navigator.pop(context);
                  _editMedication(medication);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Удалить',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMedication(medication.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editMedication(Medication medication) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => _AddMedicationSheet(
          initialName: medication.name,
          initialTime: medication.time,
          onAdd: (name, time) {
            setState(() {
              _medications = _medications.map((med) {
                if (med.id == medication.id) {
                  return med.copyWith(name: name, time: time);
                }
                return med;
              }).toList();
            });
            _saveMedications();
          },
        ),
      ),
    );
  }

  void _deleteMedication(String id) {
    setState(() {
      _medications.removeWhere((med) => med.id == id);
    });
    _saveMedications();
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }
}

class _AddMedicationSheet extends StatefulWidget {
  const _AddMedicationSheet({
    required this.onAdd,
    this.initialName,
    this.initialTime,
  });

  final void Function(String name, TimeOfDay time) onAdd;
  final String? initialName;
  final TimeOfDay? initialTime;

  @override
  State<_AddMedicationSheet> createState() => _AddMedicationSheetState();
}

class _AddMedicationSheetState extends State<_AddMedicationSheet> {
  late final TextEditingController _nameController;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _selectedTime = widget.initialTime ?? const TimeOfDay(hour: 9, minute: 0);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.initialName != null
                  ? 'Редактировать препарат'
                  : 'Добавить препарат',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Название препарата',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _selectTime,
              icon: const Icon(Icons.access_time),
              label: Text('Время напоминания: ${_formatTime(_selectedTime)}'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _nameController.text.isNotEmpty ? _save : null,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _save() {
    widget.onAdd(_nameController.text, _selectedTime);
    Navigator.pop(context);
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }
}
