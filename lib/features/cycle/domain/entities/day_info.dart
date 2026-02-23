import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:periodility/core/l10n/gen/app_localizations.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';

enum PregnancyProbability { none, low, medium, high }

class DayInfo extends Equatable {
  const DayInfo({
    required this.date,
    required this.cycleDay,
    required this.phase,
    required this.pregnancyProbability,
    this.isMenstruation = false,
    this.isOvulationDay = false,
    this.daysUntilNextPeriod,
  });

  final DateTime date;
  final int cycleDay;
  final CyclePhase phase;
  final PregnancyProbability pregnancyProbability;
  final bool isMenstruation;
  final bool isOvulationDay;
  final int? daysUntilNextPeriod;

  String phaseDescription(AppLocalizations l10n) {
    switch (phase) {
      case CyclePhase.menstruation:
        return l10n.phase_menstruation;
      case CyclePhase.follicular:
        return l10n.phase_follicular;
      case CyclePhase.ovulation:
        return l10n.phase_ovulation;
      case CyclePhase.luteal:
        return l10n.phase_luteal;
    }
  }

  Color get phaseColor {
    switch (phase) {
      case CyclePhase.menstruation:
        return Colors.red;
      case CyclePhase.follicular:
        return Colors.green;
      case CyclePhase.ovulation:
        return Colors.purple;
      case CyclePhase.luteal:
        return Colors.orange;
    }
  }

  IconData get phaseIcon {
    switch (phase) {
      case CyclePhase.menstruation:
        return Symbols.water_drop_rounded;
      case CyclePhase.follicular:
        return Symbols.spa_rounded;
      case CyclePhase.ovulation:
        return Symbols.egg_alt_rounded;
      case CyclePhase.luteal:
        return Symbols.nightlight_rounded;
    }
  }

  String pregnancyProbabilityDescription(AppLocalizations l10n) {
    switch (pregnancyProbability) {
      case PregnancyProbability.none:
        return l10n.prob_very_low;
      case PregnancyProbability.low:
        return l10n.prob_low;
      case PregnancyProbability.medium:
        return l10n.prob_medium;
      case PregnancyProbability.high:
        return l10n.prob_high;
    }
  }

  bool get pregnancyDanger {
    switch (pregnancyProbability) {
      case PregnancyProbability.none:
        return false;
      case PregnancyProbability.low:
        return false;
      case PregnancyProbability.medium:
        return true;
      case PregnancyProbability.high:
        return true;
    }
  }

  @override
  List<Object?> get props => [
    date,
    cycleDay,
    phase,
    pregnancyProbability,
    isMenstruation,
    isOvulationDay,
    daysUntilNextPeriod,
  ];
}
