import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:periodility/core/common/widgets/block_container.dart';
import 'package:periodility/core/common/widgets/custom_list_tile.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/sliver_fill_overscroll.dart';
import 'package:periodility/core/common/widgets/tiles_column_view.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/core/constants/log_constants.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/cycle/domain/entities/flow_level.dart';
import 'package:periodility/features/cycle/presentation/cubit/daily_logs_cubit.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:material_symbols_icons/symbols.dart';

class CalendarAddLogSheet extends StatefulWidget {
  const CalendarAddLogSheet({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  State<CalendarAddLogSheet> createState() => _CalendarAddLogSheetState();
}

class _CalendarAddLogSheetState extends State<CalendarAddLogSheet> {
  final List<FlowLevel> _selectedFlowLevels = [];
  String? _selectedMood;
  final List<String> _selectedSymptoms = [];
  late final TextEditingController _notesController;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    context.read<DailyLogsCubit>().loadLogForDate(widget.date);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _syncWithState(DailyLogsState state) {
    if (_initialized) return;
    final log = state.currentLog;
    if (log != null && log.date.day == widget.date.day) {
      if (log.flowLevels != null) {
        _selectedFlowLevels.addAll(log.flowLevels!);
      }
      _selectedMood = log.mood;
      if (log.symptoms != null) {
        _selectedSymptoms.addAll(log.symptoms!);
      }
      _notesController.text = log.notes ?? '';
    }
    _initialized = true;
  }

  void _save(BuildContext context) {
    context.read<DailyLogsCubit>().saveLog(
      symptoms: _selectedSymptoms.isNotEmpty ? _selectedSymptoms : null,
      mood: _selectedMood,
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      flowLevels: _selectedFlowLevels.isNotEmpty ? _selectedFlowLevels : null,
    );
    context.pop();
  }

  void _toggleFlow(FlowLevel level) {
    setState(() {
      if (_selectedFlowLevels.contains(level)) {
        _selectedFlowLevels.remove(level);
      } else {
        _selectedFlowLevels.add(level);
      }
    });
  }

  void _toggleMood(String mood) {
    setState(() {
      if (_selectedMood == mood) {
        _selectedMood = null;
      } else {
        _selectedMood = mood;
      }
    });
  }

  void _toggleSymptom(String symptom) {
    setState(() {
      if (_selectedSymptoms.contains(symptom)) {
        _selectedSymptoms.remove(symptom);
      } else {
        _selectedSymptoms.add(symptom);
      }
    });
  }

  Future<void> _selectDate() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDate != null && newDate != widget.date && mounted) {
      final dateStr = newDate.toIso8601String();
      context.pop();
      context.push('/calendar/add-log?date=$dateStr');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final formattedDate = DateFormat(
      'd MMMM yyyy',
      context.l10n.localeName,
    ).format(widget.date);

    return BlocConsumer<DailyLogsCubit, DailyLogsState>(
      listenWhen: (prev, current) => prev.isLoading && !current.isLoading,
      listener: (context, state) {
        if (!state.isLoading) {
          setState(() {
            _syncWithState(state);
          });
        }
      },
      builder: (context, state) {
        if (state.isLoading && !_initialized) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // In case listener didn't fire (already loaded)
        if (!_initialized && !state.isLoading) {
          _syncWithState(state);
        }

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (!didPop && context.mounted) {
              context.pop();
            }
          },
          child: Sheet(
            decoration: MaterialSheetDecoration(
              size: SheetSize.stretch,
              color: colorScheme.surface,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
            ),
            child: SheetContentScaffold(
              body: CustomScrollView(
                slivers: [
                  TrackerAppBar(
                    leading: IconButton(
                      icon: const Icon(Symbols.close_rounded),
                      onPressed: () => context.pop(),
                    ),
                    title: GestureDetector(
                      onTap: _selectDate,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(formattedDate, style: textTheme.titleMedium),
                          const SizedBox(width: 4),
                          const Icon(Symbols.arrow_drop_down_rounded),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Symbols.check_rounded),
                        onPressed: () => _save(context),
                      ),
                    ],
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverList.list(
                    children: [
                      _buildFlowSection(textTheme),
                      const SizedBox(height: 16),
                      _buildMoodSection(textTheme),
                      const SizedBox(height: 16),
                      _buildSymptomsSection(textTheme, colorScheme),
                      const SizedBox(height: 16),
                      _buildNotesSection(textTheme),
                    ],
                  ),
                  SliverFillOverscroll(
                    child: ColoredBox(color: colorScheme.surface),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFlowSection(TextTheme textTheme) {
    return BlockContainer(
      bottomRounded: true,
      child: SectionContainer(
        title: 'Выделения',
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: FlowLevel.values.map((flow) {
            final isSelected = _selectedFlowLevels.contains(flow);
            return FilterChip(
              label: Text(flow.displayName),
              selected: isSelected,
              onSelected: (_) => _toggleFlow(flow),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMoodSection(TextTheme textTheme) {
    return BlockContainer(
      bottomRounded: true,
      child: SectionContainer(
        title: 'Настроение',
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            spacing: 8,
            children: LogConstants.moods.map((mood) {
              final isSelected = _selectedMood == mood;
              return ChoiceChip(
                label: Text(mood),
                selected: isSelected,
                onSelected: (_) => _toggleMood(mood),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomsSection(TextTheme textTheme, ColorScheme colorScheme) {
    return BlockContainer(
      bottomRounded: true,
      child: SectionContainer(
        title: 'Симптомы',
        child: TilesColumnView(
          children: LogConstants.symptomsByCategory.entries.map((entry) {
            final category = entry.key;
            final symptoms = entry.value;
            final selectedCount = symptoms
                .where(_selectedSymptoms.contains)
                .length;

            return CustomListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(category, overflow: TextOverflow.ellipsis),
                  ),
                  if (selectedCount > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$selectedCount',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      children:
                          (symptoms.toList()..sort((a, b) {
                                final selA = _selectedSymptoms.contains(a);
                                final selB = _selectedSymptoms.contains(b);
                                if (selA == selB) return a.compareTo(b);
                                return selA ? -1 : 1;
                              }))
                              .map((symptom) {
                                final isSelected = _selectedSymptoms.contains(
                                  symptom,
                                );
                                return FilterChip(
                                  label: Text(symptom),
                                  selected: isSelected,
                                  onSelected: (_) => _toggleSymptom(symptom),
                                );
                              })
                              .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNotesSection(TextTheme textTheme) {
    return BlockContainer(
      child: SectionContainer(
        title: 'Заметки',
        child: TextField(
          controller: _notesController,
          maxLines: 4,
          minLines: 2,
          decoration: InputDecoration(
            hintText: 'Добавьте заметки о вашем дне...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
