import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/cycle/data/models/cycle_log_model.dart';

abstract class CycleLocalDataSource {
  List<CycleLogModel> getCycleLogs();
  Future<void> saveCycleLogs(List<CycleLogModel> logs);
  Future<void> addCycleLog(CycleLogModel log);
  Future<void> updateCycleLog(CycleLogModel log);
  Future<void> deleteCycleLog(String id);
  Future<void> clearAll();
}

class CycleLocalDataSourceImpl implements CycleLocalDataSource {
  CycleLocalDataSourceImpl(this._storage);

  final LocalStorageService _storage;

  @override
  List<CycleLogModel> getCycleLogs() {
    final data = _storage.getCycleLogs();
    return data.map((e) => CycleLogModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveCycleLogs(List<CycleLogModel> logs) async {
    final data = logs.map((e) => e.toJson()).toList();
    await _storage.saveCycleLogs(data);
  }

  @override
  Future<void> addCycleLog(CycleLogModel log) async {
    final logs = getCycleLogs();
    logs.add(log);
    await saveCycleLogs(logs);
  }

  @override
  Future<void> updateCycleLog(CycleLogModel log) async {
    final logs = getCycleLogs();
    final index = logs.indexWhere((e) => e.id == log.id);
    if (index != -1) {
      logs[index] = log;
      await saveCycleLogs(logs);
    }
  }

  @override
  Future<void> deleteCycleLog(String id) async {
    final logs = getCycleLogs();
    logs.removeWhere((e) => e.id == id);
    await saveCycleLogs(logs);
  }

  @override
  Future<void> clearAll() async {
    await saveCycleLogs([]);
  }
}
