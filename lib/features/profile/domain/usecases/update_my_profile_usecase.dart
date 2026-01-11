import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';
import 'package:period_tracker/features/profile/domain/repositories/profile_repository.dart';

class UpdateMyProfileUseCase {
  UpdateMyProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, ProfileEntity>> call({
    String? displayName,
    DateTime? birthday,
    int? cycleAvgLength,
    int? periodAvgLength,
    String? avatarUrl,
  }) => _repository.updateMyProfile(
    displayName: displayName,
    birthday: birthday,
    cycleAvgLength: cycleAvgLength,
    periodAvgLength: periodAvgLength,
    avatarUrl: avatarUrl,
  );
}
