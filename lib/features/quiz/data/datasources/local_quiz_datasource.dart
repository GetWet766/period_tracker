import 'package:period_tracker/core/services/local_storage_service.dart';

abstract class LocalQuizDataSource {
  Map<String, dynamic> getQuizAnswers();
  Future<void> saveQuizAnswer(String questionId, dynamic answer);
  Future<void> saveQuizAnswers(Map<String, dynamic> answers);
  Future<void> setQuizCompleted({required bool value});
  bool isQuizCompleted();
}

class LocalQuizDataSourceImpl implements LocalQuizDataSource {
  LocalQuizDataSourceImpl(this._storage);

  final LocalStorageService _storage;

  @override
  Map<String, dynamic> getQuizAnswers() {
    return _storage.getQuizAnswers();
  }

  @override
  Future<void> saveQuizAnswer(String questionId, dynamic answer) async {
    final answers = _storage.getQuizAnswers();
    answers[questionId] = answer;
    await _storage.saveQuizAnswers(answers);
  }

  @override
  Future<void> saveQuizAnswers(Map<String, dynamic> answers) async {
    await _storage.saveQuizAnswers(answers);
  }

  @override
  Future<void> setQuizCompleted({required bool value}) async {
    await _storage.setQuizCompleted(value: value);
  }

  @override
  bool isQuizCompleted() {
    return _storage.isQuizCompleted;
  }
}
