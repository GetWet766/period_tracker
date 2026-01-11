import 'package:period_tracker/features/cycle/data/models/cycle_log_model.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CycleRemoteDataSource {
  Future<List<CycleLogModel>> getCycleLogs({DateTime? from, DateTime? to});
  Future<List<CycleLogModel>> getPartnerCycleLogs({
    required String partnerId,
    DateTime? from,
    DateTime? to,
  });
  Future<CycleLogModel?> getCycleLogByDate(DateTime date);
  Future<CycleLogModel> createCycleLog({
    required DateTime date,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  });
  Future<CycleLogModel> updateCycleLog({
    required String id,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  });
  Future<void> deleteCycleLog(String id);
}

class CycleRemoteDataSourceImpl implements CycleRemoteDataSource {
  CycleRemoteDataSourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<List<CycleLogModel>> getCycleLogs({
    DateTime? from,
    DateTime? to,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    try {
      var query = _client.from('cycle_logs').select().eq('user_id', userId);

      if (from != null) {
        query = query.gte('date', from.toIso8601String().split('T')[0]);
      }
      if (to != null) {
        query = query.lte('date', to.toIso8601String().split('T')[0]);
      }

      final response = await query.order('date', ascending: false);
      return (response as List)
          .map((e) => CycleLogModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Ошибка получения логов цикла: $e');
    }
  }

  @override
  Future<List<CycleLogModel>> getPartnerCycleLogs({
    required String partnerId,
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      var query = _client.from('cycle_logs').select().eq('user_id', partnerId);

      if (from != null) {
        query = query.gte('date', from.toIso8601String().split('T')[0]);
      }
      if (to != null) {
        query = query.lte('date', to.toIso8601String().split('T')[0]);
      }

      final response = await query.order('date', ascending: false);
      return (response as List)
          .map((e) => CycleLogModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Ошибка получения логов партнёра: $e');
    }
  }

  @override
  Future<CycleLogModel?> getCycleLogByDate(DateTime date) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    try {
      final dateStr = date.toIso8601String().split('T')[0];
      final response = await _client
          .from('cycle_logs')
          .select()
          .eq('user_id', userId)
          .eq('date', dateStr)
          .maybeSingle();

      if (response == null) return null;
      return CycleLogModel.fromJson(response);
    } catch (e) {
      throw Exception('Ошибка получения лога: $e');
    }
  }

  @override
  Future<CycleLogModel> createCycleLog({
    required DateTime date,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Пользователь не авторизован');

    try {
      final response = await _client
          .from('cycle_logs')
          .insert({
            'user_id': userId,
            'date': date.toIso8601String().split('T')[0],
            if (flowLevel != null) 'flow_level': flowLevel.name,
            if (symptoms != null) 'symptoms': symptoms,
            if (notes != null) 'notes': notes,
          })
          .select()
          .single();

      return CycleLogModel.fromJson(response);
    } catch (e) {
      throw Exception('Ошибка создания лога: $e');
    }
  }

  @override
  Future<CycleLogModel> updateCycleLog({
    required String id,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) async {
    try {
      final updateData = <String, dynamic>{
        if (flowLevel != null) 'flow_level': flowLevel.name,
        if (symptoms != null) 'symptoms': symptoms,
        if (notes != null) 'notes': notes,
      };

      if (updateData.isEmpty) {
        final response = await _client
            .from('cycle_logs')
            .select()
            .eq('id', id)
            .single();
        return CycleLogModel.fromJson(response);
      }

      final response = await _client
          .from('cycle_logs')
          .update(updateData)
          .eq('id', id)
          .select()
          .single();

      return CycleLogModel.fromJson(response);
    } catch (e) {
      throw Exception('Ошибка обновления лога: $e');
    }
  }

  @override
  Future<void> deleteCycleLog(String id) async {
    try {
      await _client.from('cycle_logs').delete().eq('id', id);
    } catch (e) {
      throw Exception('Ошибка удаления лога: $e');
    }
  }
}
