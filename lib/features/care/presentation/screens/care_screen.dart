import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/care/data/care_data.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  @override
  State<CareScreen> createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  List<Medication> _medications = [
    const Medication(
      id: '1',
      name: 'Оральные контрацептивы',
      time: TimeOfDay(hour: 9, minute: 0),
    ),
  ];

  WaterReminder _waterReminder = const WaterReminder(
    targetGlasses: 8,
    currentGlasses: 0,
  );

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
                  color: Colors.blue.withOpacity(0.15),
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
                      '${_waterReminder.currentGlasses} из ${_waterReminder.targetGlasses} стаканов',
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
    final textTheme = TextTheme.of(context);

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
    final textTheme = TextTheme.of(context);

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
                        Expanded(
                          child: Text(
                            entry.value,
                            style: textTheme.bodyMedium,
                          ),
                        ),
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
            color: category.color.withOpacity(0.15),
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
  }

  void _addMedication() {
    showModalBottomSheet(
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
        },
      ),
    );
  }

  void _showMedicationOptions(Medication medication) {
    showModalBottomSheet(
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
              title: const Text('Удалить', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _deleteMedication(medication.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editMedication(Medication medication) {
    showModalBottomSheet(
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
        },
      ),
    );
  }

  void _deleteMedication(String id) {
    setState(() {
      _medications.removeWhere((med) => med.id == id);
    });
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
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
    final colorScheme = ColorScheme.of(context);
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
              label: Text(
                'Время напоминания: ${_formatTime(_selectedTime)}',
              ),
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
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
