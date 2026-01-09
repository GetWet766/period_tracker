import 'package:flutter/material.dart';
import 'package:period_tracker/core/app/app.dart';
import 'package:period_tracker/core/injection/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();

  runApp(const PeriodTracker());
}
