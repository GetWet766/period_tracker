import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/common/usecase/usecase.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';
import 'package:period_tracker/features/profile/domain/repositories/profile_repository.dart';

class UpdateMyProfileUseCase
    implements UseCaseWithParams<ProfileEntity, UpdateMyProfileParams> {
  UpdateMyProfileUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateMyProfileParams params) =>
      _repository.updateMyProfile(
        displayName: params.displayName,
        birthday: params.birthDate,
        cycleAvgLength: params.cycleAvgLength,
        periodAvgLength: params.periodAvgLength,
        avatarUrl: params.avatarUrl,
      );
}

class UpdateMyProfileParams {
  UpdateMyProfileParams({
    this.displayName,
    this.birthDate,
    this.cycleAvgLength,
    this.periodAvgLength,
    this.avatarUrl,
  });

  final String? displayName;
  final DateTime? birthDate;
  final int? cycleAvgLength;
  final int? periodAvgLength;
  final String? avatarUrl;
}
