import 'package:flutter/material.dart';
import 'package:period_tracker/core/router/router.dart';

class PeriodTracker extends StatelessWidget {
  const PeriodTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.pink)),
      darkTheme: ThemeData(
        brightness: .dark,
        colorScheme: .fromSeed(brightness: .dark, seedColor: Colors.pink),
      ),

      routerConfig: AppRouter().config,
    );
  }
}
