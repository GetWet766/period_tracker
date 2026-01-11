import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/profile/domain/repositories/profile_repository.dart';

class GetPartnerConnectionUseCase {
  GetPartnerConnectionUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, Map<String, dynamic>?>> call() =>
      _repository.getPartnerConnection();
}
