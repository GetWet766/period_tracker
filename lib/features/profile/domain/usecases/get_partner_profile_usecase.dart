import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';
import 'package:period_tracker/features/profile/domain/repositories/profile_repository.dart';

class GetPartnerProfileUseCase {
  GetPartnerProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, ProfileEntity?>> call() =>
      _repository.getPartnerProfile();
}
