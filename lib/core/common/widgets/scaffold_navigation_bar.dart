import 'package:flutter/material.dart';

class ScaffoldNavigationBar extends StatelessWidget {
  const ScaffoldNavigationBar({
    required this.body,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });
  final Widget body;
  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: destinations
            .map(
              (dest) =>
                  NavigationDestination(icon: dest.icon, label: dest.label),
            )
            .toList(),
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
