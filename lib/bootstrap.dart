import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  Bloc.observer = TalkerBlocObserver(
    talker: sl(),
    // settings: const TalkerBlocLoggerSettings(
    //   printChanges: true,
    // ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarIconBrightness: .light,
    ),
  );

  FlutterError.onError = (details) {
    sl<Talker>().handle(details.exception, details.stack);
  };

  runApp(await builder());
}
