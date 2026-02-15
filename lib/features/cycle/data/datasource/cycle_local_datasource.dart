import 'package:isar_plus/isar_plus.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/utils/fast_hash_extension.dart';
import 'package:periodility/features/cycle/data/models/cycle_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class CycleLocalDataSource {
  Future<void> saveCycle(CycleModel cycle);
  Future<CycleModel?> getLatestCycle();
  Future<List<CycleModel>> getAllCycles();
  Future<CycleModel?> getCycleByDate(DateTime date);
  Future<void> deleteCycle(String id);
}

class CycleLocalDataSourceImpl implements CycleLocalDataSource {
  const CycleLocalDataSourceImpl(this._client);

  final Isar _client;

  @override
  Future<void> saveCycle(CycleModel cycle) async {
    final cycleModel = cycle.copyWith(
      createdAt: DateTime.now(),
    );

    await _client.writeAsync((isar) {
      isar.cycleModels.put(cycleModel);
    });
  }

  // Получить самый свежий цикл (текущий)
  @override
  Future<CycleModel?> getLatestCycle() async {
    sl<Talker>().handle(await getAllCycles());

    // await _client.writeAsync(
    //   (isar) {
    //     isar.cycleModels.clear();
    //   },
    // );

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
        .where()
        .startDateLessThanOrEqualTo(date)
        .and()
        .endDateGreaterThanOrEqualTo(date)
        .findFirst();
  }

  @override
  Future<void> deleteCycle(String id) async {
    await _client.writeAsync((isar) {
      isar.cycleModels.delete(id.fastHash());
    });
  }
}
