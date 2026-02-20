import 'package:isar_plus/isar_plus.dart';

enum FlowLevel {
  spotting('Мажущие'),
  low('Скудные'),
  medium('Умеренные'),
  heavy('Обильные'),
  sticky('Вязкие')
  ;

  const FlowLevel(this.displayName);

  @enumValue
  final String displayName;
}
