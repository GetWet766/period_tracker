import 'package:isar_plus/isar_plus.dart';
import 'package:periodility/core/l10n/gen/app_localizations.dart';
import 'package:periodility/core/l10n/l10n_mapper.dart';

enum FlowLevel {
  spotting('flow_spotting'),
  low('flow_low'),
  medium('flow_medium'),
  heavy('flow_heavy'),
  sticky('flow_sticky')
  ;

  const FlowLevel(this.l10nKey);

  @enumValue
  final String l10nKey;

  String getLocalizedName(AppLocalizations l10n) =>
      translateL10n(l10nKey, l10n);

  // For backward compatibility if needed, but better use localized one
  String get displayName => l10nKey;
}
