import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteQuizDataSource {
  Future<void> syncQuizDataToProfile(Map<String, dynamic> quizAnswers);
}

class RemoteQuizDataSourceImpl implements RemoteQuizDataSource {
  RemoteQuizDataSourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<void> syncQuizDataToProfile(Map<String, dynamic> quizAnswers) async {
    final userId = _client.auth.currentSession?.user.id;
    if (userId == null) return;

    // Extract profile data from quiz answers
    final profileData = <String, dynamic>{};
    final profileDetailsData = <String, dynamic>{};

    // Map quiz answers to profile fields
    if (quizAnswers.containsKey('name')) {
      profileData['display_name'] = quizAnswers['name'];
    }

    // Map to profile_details
    if (quizAnswers.containsKey('birth_date')) {
      profileDetailsData['birth_date'] = quizAnswers['birth_date'];
    }
    if (quizAnswers.containsKey('weight')) {
      profileDetailsData['weight'] = quizAnswers['weight'];
    }
    if (quizAnswers.containsKey('height')) {
      profileDetailsData['height'] = quizAnswers['height'];
    }
    if (quizAnswers.containsKey('period_avg_length')) {
      profileDetailsData['period_avg_length'] =
          quizAnswers['period_avg_length'];
    }
    if (quizAnswers.containsKey('cycle_avg_length')) {
      profileDetailsData['cycle_avg_length'] = quizAnswers['cycle_avg_length'];
    }
    if (quizAnswers.containsKey('last_period')) {
      profileDetailsData['last_period'] = quizAnswers['last_period'];
    }

    // Update profile if there's data
    if (profileData.isNotEmpty) {
      await _client.from('profile').update(profileData).eq('id', userId);
    }

    // Update profile_details if there's data
    if (profileDetailsData.isNotEmpty) {
      // First check if profile_details exists
      final existing = await _client
          .from('profile_details')
          .select()
          .eq('profile_id', userId)
          .maybeSingle();

      if (existing != null) {
        await _client
            .from('profile_details')
            .update(profileDetailsData)
            .eq('profile_id', userId);
      } else {
        await _client.from('profile_details').insert({
          'profile_id': userId,
          ...profileDetailsData,
        });
      }
    }
  }
}
