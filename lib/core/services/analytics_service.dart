import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AnalyticsService {
  AnalyticsService({
    required this.talker,
  });

  final Talker talker;
  FirebaseAnalytics get _firebaseAnalytics => FirebaseAnalytics.instance;

  Future<void> init(String appMetricaKey) async {
    try {
      await AppMetrica.activate(AppMetricaConfig(appMetricaKey));
      talker.info('AppMetrica initialized');
    } catch (e, st) {
      talker.error('Failed to initialize AppMetrica', e, st);
    }

    try {
      if (!kIsWeb) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
          !kDebugMode,
        );

        // Pass all uncaught errors from the framework to Crashlytics.
        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };

        // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
        talker.info('Firebase Crashlytics initialized');
      }
    } catch (e, st) {
      talker.error(
        'Failed to initialize Firebase Analytics/Crashlytics',
        e,
        st,
      );
    }
  }

  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    talker.info('Analytics Event: $name, Parameters: $parameters');

    try {
      await _firebaseAnalytics.logEvent(name: name, parameters: parameters);
      await AppMetrica.reportEventWithMap(name, parameters);
    } catch (e, st) {
      talker.error('Failed to log event', e, st);
    }
  }

  Future<void> logScreenView(String screenName) async {
    talker.info('Analytics Screen: $screenName');
    try {
      await _firebaseAnalytics.logScreenView(screenName: screenName);
      // AppMetrica doesn't have a direct setCurrentScreen, but we can log an event
      await AppMetrica.reportEventWithMap(
        'screen_view',
        {'screen_name': screenName},
      );
    } catch (e, st) {
      talker.error('Failed to log screen view', e, st);
    }
  }

  Future<void> setUserIdentifier(String id) async {
    try {
      await _firebaseAnalytics.setUserId(id: id);
      await AppMetrica.setUserProfileID(id);
      if (!kIsWeb) {
        await FirebaseCrashlytics.instance.setUserIdentifier(id);
      }
    } catch (e, st) {
      talker.error('Failed to set user identifier', e, st);
    }
  }
}
