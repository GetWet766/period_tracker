import 'package:isar_plus/isar_plus.dart';

enum FlowLevel {
  low('Скудные'),
  medium('Умеренные'),
  heavy('Обильные')
  ;

  const FlowLevel(this.displayName);

  @enumValue
  final String displayName;
}
