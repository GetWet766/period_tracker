import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:periodility/core/common/widgets/widgets.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/services/analytics_service.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/home/presentation/widgets/home_main_info.dart';
import 'package:periodility/features/home/presentation/widgets/my_cycles.dart';
import 'package:periodility/features/home/presentation/widgets/phases_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routePath = '/home';
  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(sl<AnalyticsService>().logScreenView('Home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParallaxSnapSheet(
        sliverAppBar: TrackerAppBar(
          title: Text(
            DateFormat(
              'd MMMM',
              context.l10n.localeName,
            ).format(DateTime.now()),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
          actions: _buildActions(),
        ),
        backgroundContent: const HomeMainInfo(),
        sheetContent: _buildContent(),
      ),
    );
  }

  List<Widget> _buildActions() {
    final colorScheme = ColorScheme.of(context);

    return [
      IconButton.filled(
        onPressed: () => context.push('/profile'),
        icon: Icon(
          Symbols.person_rounded,
          color: colorScheme.onPrimary,
        ),
      ),
    ];
  }

  Widget _buildContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        PhasesSection(),
        // TODO: implement partner feature
        // InvitePartnerBanner(
        //   onPressed: () {},
        // ),
        AppBannerAd(
          defaultHeight: 180,
        ),
        MyCycles(),
      ],
    );
  }
}
