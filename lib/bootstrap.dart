import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  Bloc.observer = TalkerBlocObserver(
    talker: sl(),
    // settings: const TalkerBlocLoggerSettings(
    //   printChanges: true,
    // ),
  );

  runApp(await builder());
}
