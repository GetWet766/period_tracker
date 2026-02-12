import 'package:flutter/widgets.dart';
import 'package:periodility/core/l10n/gen/app_localizations.dart';

extension LocaleExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
