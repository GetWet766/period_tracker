import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/profile/data/models/profile_model.dart';

abstract class ProfileLocalDataSource {
  ProfileModel? getProfile();
  Future<void> saveProfile(ProfileModel profile);
  Future<void> clearProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl(this._storage);

  final LocalStorageService _storage;

  @override
  ProfileModel? getProfile() {
    final data = _storage.getProfile();
    if (data == null) return null;
    return ProfileModel.fromJson(data);
  }

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    await _storage.saveProfile(profile.toJson());
  }

  @override
  Future<void> clearProfile() async {
    await _storage.saveProfile({});
  }
}
