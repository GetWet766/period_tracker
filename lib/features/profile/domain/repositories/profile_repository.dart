import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getMyProfile();

  Future<Either<Failure, ProfileEntity>> updateMyProfile({
    String? displayName,
    DateTime? birthday,
    int? cycleAvgLength,
    int? periodAvgLength,
    String? avatarUrl,
  });

  Future<Either<Failure, String>> createPartnerInvite();
  Future<Either<Failure, String>> joinAsPartner(String inviteCode);
  Future<Either<Failure, ProfileEntity?>> getPartnerProfile();
  Future<Either<Failure, Map<String, dynamic>?>> getPartnerConnection();
}
