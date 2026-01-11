import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/profile/domain/repositories/profile_repository.dart';

class JoinAsPartnerUseCase {
  JoinAsPartnerUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, String>> call(String inviteCode) =>
      _repository.joinAsPartner(inviteCode);
}
