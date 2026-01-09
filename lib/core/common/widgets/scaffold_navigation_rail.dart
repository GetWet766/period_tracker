import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ScaffoldNavigationRail extends StatefulWidget {
  const ScaffoldNavigationRail({
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
  State<ScaffoldNavigationRail> createState() => _ScaffoldNavigationRailState();
}

class _ScaffoldNavigationRailState extends State<ScaffoldNavigationRail> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: Row(
        children: [
          Padding(
            padding: const .symmetric(vertical: 24),
            child: NavigationRail(
              extended: isExpanded,
              labelType: .none,
              backgroundColor: Colors.transparent,
              leading: context.isDesktop
                  ? IconButton(
                      icon: HugeIcon(
                        icon: isExpanded
                            ? HugeIcons.strokeRoundedMenuCollapse
                            : HugeIcons.strokeRoundedMenu01,
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    )
                  : null,
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected,
              destinations: widget.destinations
                  .map(
                    (dest) => NavigationRailDestination(
                      icon: dest.icon,
                      label: Text(dest.label),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const .only(top: 24, bottom: 24, right: 24),
              child: Container(
                clipBehavior: .antiAlias,
                decoration: BoxDecoration(
                  borderRadius: .circular(28),
                  color: colorScheme.surface,
                ),
                child: widget.body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
