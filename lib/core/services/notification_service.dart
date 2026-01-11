import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'period_tracker_channel';
  static const _channelName = 'Period Tracker';
  static const _channelDescription = 'Уведомления о цикле и напоминания';

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
  }

  Future<bool> requestPermissions() async {
    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final ios = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }

    if (ios != null) {
      final granted = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return false;
  }

  // Schedule period reminder
  Future<void> schedulePeriodReminder({
    required DateTime nextPeriodDate,
    required int daysBefore,
  }) async {
    await _notifications.cancel(1);

    final reminderDate = nextPeriodDate.subtract(Duration(days: daysBefore));
    if (reminderDate.isBefore(DateTime.now())) return;

    await _notifications.zonedSchedule(
      1,
      'Напоминание о менструации',
      'Менструация ожидается через $daysBefore дн.',
      tz.TZDateTime.from(reminderDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Schedule ovulation reminder
  Future<void> scheduleOvulationReminder({
    required DateTime ovulationDate,
  }) async {
    await _notifications.cancel(2);

    final reminderDate = ovulationDate.subtract(const Duration(days: 1));
    if (reminderDate.isBefore(DateTime.now())) return;

    await _notifications.zonedSchedule(
      2,
      'Напоминание об овуляции',
      'Овуляция ожидается завтра',
      tz.TZDateTime.from(reminderDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Schedule medication reminder (daily)
  Future<void> scheduleMedicationReminder({
    required int id,
    required String medicationName,
    required TimeOfDay time,
  }) async {
    final notificationId = 100 + id;
    await _notifications.cancel(notificationId);

    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      notificationId,
      'Напоминание о препарате',
      'Время принять: $medicationName',
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // Schedule water reminder (repeating)
  Future<void> scheduleWaterReminder({required int intervalHours}) async {
    await _notifications.cancel(3);

    await _notifications.periodicallyShow(
      3,
      'Напоминание о воде',
      'Не забудьте выпить стакан воды',
      RepeatInterval.hourly,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelMedicationReminder(int id) async {
    await _notifications.cancel(100 + id);
  }

  Future<void> cancelWaterReminder() async {
    await _notifications.cancel(3);
  }

  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
