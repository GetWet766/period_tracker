import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:period_tracker/core/common/widgets/scaffold_navigation_bar.dart';
import 'package:period_tracker/core/common/widgets/scaffold_navigation_rail.dart';

class ScaffoldNavigation extends StatelessWidget {
  ScaffoldNavigation({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  final List<NavigationDestination> destinations = [
    const NavigationDestination(
      label: 'Главная',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedHome07),
    ),
    const NavigationDestination(
      label: 'Календарь',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar02),
    ),
    const NavigationDestination(
      label: 'Уход',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedHeartCheck),
    ),
  ];

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
