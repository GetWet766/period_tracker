import 'package:isar_community/isar.dart';
import 'package:periodility/features/cycle/data/models/cycle_model.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';

abstract class CycleLocalDataSource {
  Future<void> saveCycle(CycleEntity cycle);
  Future<CycleModel?> getLatestCycle();
  Future<List<CycleModel>> getAllCycles();
  Future<CycleModel?> getCycleByDate(DateTime date);
  Future<void> deleteCycle(String id);
}

class CycleLocalDataSourceImpl implements CycleLocalDataSource {
  const CycleLocalDataSourceImpl(this._client);

  final Isar _client;

  @override
  Future<void> saveCycle(CycleEntity cycle) async {
    final cycleModel = CycleModel(
      id: cycle.id,
      userId: cycle.userId,
      startDate: cycle.startDate,
      endDate: cycle.endDate,
      createdAt: DateTime.now(),
      isManuallyStarted: cycle.isManuallyStarted,
    );

    await _client.writeTxn(() async {
      await _client.cycleModels.put(cycleModel);
    });
  }

  // Получить самый свежий цикл (текущий)
  @override
  Future<CycleModel?> getLatestCycle() async {
    return _client.cycleModels.where().sortByStartDateDesc().findFirst();
  }

  // Получить все циклы для истории и аналитики
  @override
  Future<List<CycleModel>> getAllCycles() async {
    return _client.cycleModels.where().sortByStartDateDesc().findAll();
  }

  // Найти цикл, в который попадает конкретная дата
  @override
  Future<CycleModel?> getCycleByDate(DateTime date) async {
    return _client.cycleModels
        .filter()
        .group(
          (q) => q.startDateLessThan(date).or().startDateEqualTo(date),
        )
        .and()
        .group(
          (q) => q.endDateIsNull().or().group(
            (q) => q.endDateGreaterThan(date).or().endDateEqualTo(date),
          ),
        )
        .findFirst();
  }

  @override
  Future<void> deleteCycle(String id) async {
    await _client.writeTxn(() async {
      final cycle = await _client.cycleModels
          .filter()
          .idEqualTo(id)
          .findFirst();
      if (cycle != null) {
        await _client.cycleModels.delete(cycle.isarId);
      }
    });
  }
}
