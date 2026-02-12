import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scaffold_navigation/src/widgets/scaffold_navigation_bar.dart';
import 'package:scaffold_navigation/src/widgets/scaffold_navigation_rail.dart';

class ScaffoldNavigation extends StatelessWidget {
  const ScaffoldNavigation({
    required this.navigationShell,
    required this.destinations,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<NavigationDestination> destinations;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, _) {
        if (context.isMobile) {
          return ScaffoldNavigationBar(
            body: navigationShell,
            destinations: destinations,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
          );
        } else {
          return ScaffoldNavigationRail(
            body: navigationShell,
            destinations: destinations,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch,
          );
        }
      },
    );
  }
}
