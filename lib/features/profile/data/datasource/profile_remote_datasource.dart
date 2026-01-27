import 'package:period_tracker/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel?> getMyProfile();
  Future<ProfileModel?> updateMyProfile({
    String? displayName,
    String? avatarUrl,
    ProfileRole? role,

    DateTime? birthDate,
    int? weight,
    int? height,
    int? cycleAvgLength,
    int? periodAvgLength,
    DateTime? lastPeriodDateStart,
    DateTime? lastPeriodDateEnd,
  });

  Future<String> createPartnerInvite();
  Future<String> joinAsPartner(String inviteCode);
  Future<Map<String, dynamic>?> getPartnerConnection();
  Future<ProfileModel?> getPartnerProfile();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<ProfileModel?> getMyProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    try {
      final response = await _client
          .from('profiles')
          .select('*, profile_details(*)')
          .eq('id', userId)
          .single();
      final profile = ProfileModel.fromJson(response);

      return profile;
    } catch (e) {
      throw UnimplementedError('Ошибка получения данных профиля: $e');
    }
  }

  @override
  Future<ProfileModel?> updateMyProfile({
    String? displayName,
    String? avatarUrl,
    ProfileRole? role,

    DateTime? birthDate,
    int? weight,
    int? height,
    int? cycleAvgLength,
    int? periodAvgLength,
    DateTime? lastPeriodDateStart,
    DateTime? lastPeriodDateEnd,
  }) async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) return null;

    try {
      final profileUpdates = <String, dynamic>{
        'display_name': ?displayName,
        'avatar_url': ?avatarUrl,
        'role': ?role,
      };
      final profileDetailsUpdates = <String, dynamic>{
        'birth_date': ?birthDate?.toIso8601String(),
        'weight': ?weight,
        'height': ?height,
        'cycle_avg_length': ?cycleAvgLength,
        'period_avg_length': ?periodAvgLength,
        'last_period_date_start': ?lastPeriodDateStart?.toIso8601String(),
        'last_period_date_end': ?lastPeriodDateEnd?.toIso8601String(),
      };

      if (profileUpdates.isNotEmpty) {
        await _client.from('profiles').update(profileUpdates).eq('id', userId);
      }

      if (profileDetailsUpdates.isNotEmpty) {
        final existingDetails = await _client
            .from('profile_details')
            .select('id')
            .eq('id', userId)
            .maybeSingle();

        if (existingDetails != null) {
          await _client
              .from('profile_details')
              .update(profileDetailsUpdates)
              .eq('id', userId);
        } else {
          await _client.from('profile_details').insert({
            ...profileDetailsUpdates,
            'id': userId,
          });
        }
      }

      return getMyProfile();
    } on Exception catch (e) {
      throw Exception('Ошибка обновления данных профиля: $e');
    }
  }

  @override
  Future<String> createPartnerInvite() async {
    try {
      final response = await _client.rpc<String>('create_partner_invite');
      return response;
    } catch (e) {
      throw UnimplementedError('Ошибка создания кода: $e');
    }
  }

  @override
  Future<String> joinAsPartner(String inviteCode) async {
    try {
      final response = await _client.rpc<Map<String, dynamic>>(
        'accept_invite',
        params: {'invite_code_text': inviteCode},
      );

      final success = response['success'] as bool? ?? false;
      if (!success) {
        final message = response['message'] as String? ?? 'Неизвестная ошибка';
        throw Exception(message);
      }

      return response['partner_id']?.toString() ?? '';
    } catch (e) {
      throw Exception('Ошибка присоединения: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getPartnerConnection() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    try {
      final response = await _client
          .from('partner_connections')
          .select()
          .eq('status', 'active')
          .or('user_id.eq.$userId,partner_id.eq.$userId')
          .maybeSingle();

      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ProfileModel?> getPartnerProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    try {
      final connection = await getPartnerConnection();
      if (connection == null) return null;

      // Определяем ID партнёра
      final isOwner = connection['user_id'] == userId;
      final partnerId =
          (isOwner ? connection['partner_id'] : connection['user_id'])
              as String?;

      if (partnerId == null) return null;

      final response = await _client
          .from('profiles')
          .select()
          .eq('id', partnerId)
          .single();

      return ProfileModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
