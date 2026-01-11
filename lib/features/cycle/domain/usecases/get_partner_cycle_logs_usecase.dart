import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/domain/repositories/cycle_repository.dart';

class GetPartnerCycleLogsUseCase {
  GetPartnerCycleLogsUseCase(this._repository);

  final CycleRepository _repository;

  Future<Either<Failure, List<CycleLogEntity>>> call({
    required String partnerId,
    DateTime? from,
    DateTime? to,
  }) => _repository.getPartnerCycleLogs(
    partnerId: partnerId,
    from: from,
    to: to,
  );
}
