import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const .all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: .circular(28),
      ),
      child: Column(crossAxisAlignment: .start, children: children),
    );
  }
}
