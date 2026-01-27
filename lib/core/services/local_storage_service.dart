import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  LocalStorageService._();

  static LocalStorageService? _instance;
  static LocalStorageService get instance {
    _instance ??= LocalStorageService._();
    return _instance!;
  }

  // Box names
  static const String _cycleLogsBox = 'cycle_logs';
  static const String _profileBox = 'profile';
  static const String _waterReminderBox = 'water_reminder';
  static const String _medicationsBox = 'medications';
  static const String _notificationSettingsBox = 'notification_settings';
  static const String _quizAnswersBox = 'quiz_answers';
  static const String _settingsBox = 'settings';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    // Open all boxes with String type for JSON storage
    await Future.wait([
      Hive.openBox<String>(_cycleLogsBox),
      Hive.openBox<String>(_profileBox),
      Hive.openBox<String>(_waterReminderBox),
      Hive.openBox<String>(_medicationsBox),
      Hive.openBox<String>(_notificationSettingsBox),
      Hive.openBox<String>(_quizAnswersBox),
      Hive.openBox<dynamic>(_settingsBox), // Mixed types box
    ]);
  }

  // Helper methods to get boxes
  Box<String> get _cycleLogs => Hive.box<String>(_cycleLogsBox);
  Box<String> get _profile => Hive.box<String>(_profileBox);
  Box<String> get _waterReminder => Hive.box<String>(_waterReminderBox);
  Box<String> get _medications => Hive.box<String>(_medicationsBox);
  Box<String> get _notificationSettings =>
      Hive.box<String>(_notificationSettingsBox);
  Box<String> get _quizAnswers => Hive.box<String>(_quizAnswersBox);
  Box<dynamic> get _settings => Hive.box<dynamic>(_settingsBox);

  // Partner Login Flow
  static const String _partnerLoginInProgressKey = 'partner_login_in_progress';

  bool get isPartnerLoginInProgress {
    final value = _settings.get(
      _partnerLoginInProgressKey,
      defaultValue: false,
    );
    return value as bool? ?? false;
  }

  Future<void> setPartnerLoginInProgress({required bool value}) async {
    await _settings.put(_partnerLoginInProgressKey, value);
  }

  // Cycle Logs
  static const String _cycleLogsDataKey = 'cycle_logs_data';

  Future<void> saveCycleLogs(List<Map<String, dynamic>> logs) async {
    await _cycleLogs.put(_cycleLogsDataKey, jsonEncode(logs));
  }

  List<Map<String, dynamic>> getCycleLogs() {
    final data = _cycleLogs.get(_cycleLogsDataKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  // Profile
  static const String _profileDataKey = 'profile_data';

  Future<void> saveProfile(Map<String, dynamic> profile) async {
    await _profile.put(_profileDataKey, jsonEncode(profile));
  }

  Map<String, dynamic>? getProfile() {
    final data = _profile.get(_profileDataKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(jsonDecode(data) as Map);
  }

  // Water Reminder
  static const String _waterReminderDataKey = 'water_reminder_data';

  Future<void> saveWaterReminder(Map<String, dynamic> reminder) async {
    await _waterReminder.put(_waterReminderDataKey, jsonEncode(reminder));
  }

  Map<String, dynamic>? getWaterReminder() {
    final data = _waterReminder.get(_waterReminderDataKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(jsonDecode(data) as Map);
  }

  // Medications
  static const String _medicationsDataKey = 'medications_data';

  Future<void> saveMedications(List<Map<String, dynamic>> medications) async {
    await _medications.put(_medicationsDataKey, jsonEncode(medications));
  }

  List<Map<String, dynamic>> getMedications() {
    final data = _medications.get(_medicationsDataKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  // Notification Settings
  static const String _notificationSettingsDataKey = 'notification_settings';

  Future<void> saveNotificationSettings(Map<String, dynamic> settings) async {
    await _notificationSettings.put(
      _notificationSettingsDataKey,
      jsonEncode(settings),
    );
  }

  Map<String, dynamic> getNotificationSettings() {
    final data = _notificationSettings.get(_notificationSettingsDataKey);
    if (data == null) {
      return {
        'periodReminder': true,
        'periodReminderDays': 2,
        'ovulationReminder': true,
        'medicationReminder': true,
        'waterReminder': true,
        'waterReminderInterval': 2,
      };
    }
    return Map<String, dynamic>.from(jsonDecode(data) as Map);
  }

  // Quiz Answers
  static const String _quizAnswersDataKey = 'quiz_answers';

  Future<void> saveQuizAnswers(Map<String, dynamic> answers) async {
    await _quizAnswers.put(_quizAnswersDataKey, jsonEncode(answers));
  }

  Map<String, dynamic> getQuizAnswers() {
    final data = _quizAnswers.get(_quizAnswersDataKey);
    if (data == null) return {};
    return Map<String, dynamic>.from(jsonDecode(data) as Map);
  }

  // Quiz completion status
  static const String _quizCompletedKey = 'quiz_completed';

  bool get isQuizCompleted {
    final value = _settings.get(_quizCompletedKey, defaultValue: false);
    return value as bool? ?? false;
  }

  Future<void> setQuizCompleted({required bool value}) async {
    await _settings.put(_quizCompletedKey, value);
  }

  // Onboarding completion status
  static const String _onboardingCompletedKey = 'onboarding_completed';

  bool get isOnboardingCompleted {
    final value = _settings.get(_onboardingCompletedKey, defaultValue: false);
    return value as bool? ?? false;
  }

  Future<void> setOnboardingCompleted({required bool value}) async {
    await _settings.put(_onboardingCompletedKey, value);
  }

  // User role selection
  static const String _userRoleKey = 'user_role';

  String? get userRole {
    final value = _settings.get(_userRoleKey);
    return value as String?;
  }

  Future<void> setUserRole(String role) async {
    await _settings.put(_userRoleKey, role);
  }

  // Partner code entered status
  static const String _partnerCodeEnteredKey = 'partner_code_entered';

  bool get isPartnerCodeEntered {
    final value = _settings.get(_partnerCodeEnteredKey, defaultValue: false);
    return value as bool? ?? false;
  }

  Future<void> setPartnerCodeEntered({required bool value}) async {
    await _settings.put(_partnerCodeEnteredKey, value);
  }

  // New user flag (for first-time registration)
  static const String _isNewUserKey = 'is_new_user';

  bool get isNewUser {
    final value = _settings.get(_isNewUserKey, defaultValue: false);
    return value as bool? ?? false;
  }

  Future<void> setIsNewUser({required bool value}) async {
    await _settings.put(_isNewUserKey, value);
  }

  // Guest mode flag
  static const String _isGuestKey = 'is_guest';

  bool get isGuest {
    final value = _settings.get(_isGuestKey, defaultValue: false);
    return value as bool? ?? false;
  }

  Future<void> setIsGuest({required bool value}) async {
    await _settings.put(_isGuestKey, value);
  }

  // Clear all data
  Future<void> clear() async {
    await Future.wait([
      _cycleLogs.clear(),
      _profile.clear(),
      _waterReminder.clear(),
      _medications.clear(),
      _notificationSettings.clear(),
      _quizAnswers.clear(),
      _settings.clear(),
    ]);
  }
}
