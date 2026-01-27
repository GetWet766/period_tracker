import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:period_tracker/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:period_tracker/features/profile/data/models/profile_details_model.dart';
import 'package:period_tracker/features/profile/data/models/profile_model.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';
import 'package:period_tracker/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getMyProfile() async {
    try {
      final profile = await _remoteDataSource.getMyProfile();

      if (profile == null) {
        // Try local for guest mode
        final localProfile = _localDataSource.getProfile();
        if (localProfile != null) {
          return Right(localProfile.toEntity());
        }
        // Return default guest profile
        return Right(_createGuestProfile());
      }

      // Cache locally
      await _localDataSource.saveProfile(profile);
      return Right(profile.toEntity());
    } on Exception {
      // Fallback to local
      try {
        final localProfile = _localDataSource.getProfile();
        if (localProfile != null) {
          return Right(localProfile.toEntity());
        }
        return Right(_createGuestProfile());
      } on Exception catch (e) {
        return Left(ServerFailure('Ошибка получения профиля: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateMyProfile({
    String? displayName,
    DateTime? birthday,
    int? cycleAvgLength,
    int? periodAvgLength,
    String? avatarUrl,
  }) async {
    try {
      final profile = await _remoteDataSource.updateMyProfile(
        displayName: displayName,
        birthDate: birthday,
        cycleAvgLength: cycleAvgLength,
        periodAvgLength: periodAvgLength,
        avatarUrl: avatarUrl,
      );

      if (profile == null) {
        // Update locally for guest mode
        return _updateLocalProfile(
          displayName: displayName,
          birthday: birthday,
          cycleAvgLength: cycleAvgLength,
          periodAvgLength: periodAvgLength,
          avatarUrl: avatarUrl,
        );
      }

      // Cache locally
      await _localDataSource.saveProfile(profile);
      return Right(profile.toEntity());
    } on Exception {
      // Update locally for offline mode
      return _updateLocalProfile(
        displayName: displayName,
        birthday: birthday,
        cycleAvgLength: cycleAvgLength,
        periodAvgLength: periodAvgLength,
        avatarUrl: avatarUrl,
      );
    }
  }

  Future<Either<Failure, ProfileEntity>> _updateLocalProfile({
    ProfileRole? role,
    String? displayName,
    DateTime? birthday,
    int? cycleAvgLength,
    int? periodAvgLength,
    String? avatarUrl,
  }) async {
    try {
      final existing = _localDataSource.getProfile();

      // Update profile details if provided
      ProfileDetailsModel? updatedDetails;
      if (existing?.details != null) {
        updatedDetails = ProfileDetailsModel(
          id: existing!.details!.id,
          birthDate: birthday ?? existing.details!.birthDate,
          weight: existing.details!.weight,
          height: existing.details!.height,
          cycleAvgLength: cycleAvgLength ?? existing.details!.cycleAvgLength,
          periodAvgLength: periodAvgLength ?? existing.details!.periodAvgLength,
          lastPeriodDateStart: existing.details!.lastPeriodDateStart,
          lastPeriodDateEnd: existing.details!.lastPeriodDateEnd,
          createdAt: existing.details!.createdAt,
          updatedAt: DateTime.now(),
        );
      } else if (birthday != null ||
          cycleAvgLength != null ||
          periodAvgLength != null) {
        // Create new details if updating cycle/period info but details don't exist
        updatedDetails = ProfileDetailsModel(
          id: 'guest_details',
          birthDate:
              birthday ??
              DateTime.now().subtract(const Duration(days: 365 * 25)),
          weight: 60,
          height: 165,
          cycleAvgLength: cycleAvgLength ?? 28,
          periodAvgLength: periodAvgLength ?? 5,
          lastPeriodDateStart: DateTime.now().subtract(
            const Duration(days: 14),
          ),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }

      final updated = ProfileModel(
        id: existing?.id ?? 'guest',
        role: role ?? existing?.role ?? ProfileRole.user,
        displayName: displayName ?? existing?.displayName,
        avatarUrl: avatarUrl ?? existing?.avatarUrl,
        createdAt: existing?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        details: updatedDetails ?? existing?.details,
      );
      await _localDataSource.saveProfile(updated);
      return Right(updated.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure('Ошибка обновления профиля: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> createPartnerInvite() async {
    try {
      final code = await _remoteDataSource.createPartnerInvite();
      return Right(code);
    } on Exception catch (e) {
      return Left(ServerFailure('Ошибка создания приглашения: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> joinAsPartner(String inviteCode) async {
    try {
      final result = await _remoteDataSource.joinAsPartner(inviteCode);
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure('Ошибка присоединения: $e'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity?>> getPartnerProfile() async {
    try {
      final profile = await _remoteDataSource.getPartnerProfile();
      if (profile == null) return const Right(null);
      return Right(profile.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure('Ошибка получения профиля партнёра: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getPartnerConnection() async {
    try {
      final connection = await _remoteDataSource.getPartnerConnection();
      return Right(connection);
    } on Exception catch (e) {
      return Left(ServerFailure('Ошибка получения связи: $e'));
    }
  }

  ProfileEntity _createGuestProfile() {
    return ProfileEntity(
      id: 'guest',
      role: .user,
      displayName: 'Гость',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
