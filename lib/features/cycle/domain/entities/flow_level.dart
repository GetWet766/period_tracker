enum FlowLevel {
  low('Скудные'),
  medium('Умеренные'),
  heavy('Обильные')
  ;

  final String displayName;
  const FlowLevel(this.displayName);
}
