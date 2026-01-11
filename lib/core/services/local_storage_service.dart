import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService(this._prefs);

  final SharedPreferences _prefs;

  static const String _cycleLogsKey = 'cycle_logs';
  static const String _profileKey = 'profile';
  static const String _waterReminderKey = 'water_reminder';
  static const String _medicationsKey = 'medications';
  static const String _notificationSettingsKey = 'notification_settings';
  static const String _quizAnswersKey = 'quiz_answers';
  static const String _partnerLoginInProgressKey = 'partner_login_in_progress';

  // Partner Login Flow
  bool get isPartnerLoginInProgress =>
      _prefs.getBool(_partnerLoginInProgressKey) ?? false;

  Future<void> setPartnerLoginInProgress(bool value) async {
    await _prefs.setBool(_partnerLoginInProgressKey, value);
  }

  // Cycle Logs
  Future<void> saveCycleLogs(List<Map<String, dynamic>> logs) async {
    await _prefs.setString(_cycleLogsKey, jsonEncode(logs));
  }

  List<Map<String, dynamic>> getCycleLogs() {
    final data = _prefs.getString(_cycleLogsKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  // Profile
  Future<void> saveProfile(Map<String, dynamic> profile) async {
    await _prefs.setString(_profileKey, jsonEncode(profile));
  }

  Map<String, dynamic>? getProfile() {
    final data = _prefs.getString(_profileKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(jsonDecode(data) as Map);
  }

  // Water Reminder
  Future<void> saveWaterReminder(Map<String, dynamic> reminder) async {
    await _prefs.setString(_waterReminderKey, jsonEncode(reminder));
  }

  Map<String, dynamic>? getWaterReminder() {
    final data = _prefs.getString(_waterReminderKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(jsonDecode(data) as Map);
  }

  // Medications
  Future<void> saveMedications(List<Map<String, dynamic>> medications) async {
    await _prefs.setString(_medicationsKey, jsonEncode(medications));
  }

  List<Map<String, dynamic>> getMedications() {
    final data = _prefs.getString(_medicationsKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  // Notification Settings
  Future<void> saveNotificationSettings(Map<String, dynamic> settings) async {
    await _prefs.setString(_notificationSettingsKey, jsonEncode(settings));
  }

  Map<String, dynamic> getNotificationSettings() {
    final data = _prefs.getString(_notificationSettingsKey);
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
  Future<void> saveQuizAnswers(Map<String, dynamic> answers) async {
    await _prefs.setString(_quizAnswersKey, jsonEncode(answers));
  }

  Map<String, dynamic> getQuizAnswers() {
    final data = _prefs.getString(_quizAnswersKey);
    if (data == null) return {};
    return Map<String, dynamic>.from(jsonDecode(data) as Map);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
