import 'package:flutter/foundation.dart';
import 'package:isar_plus/isar_plus.dart';

extension IsarExtension on Isar {
  Future<T> writeAdaptive<T>(T Function(Isar) callback) async {
    if (kIsWeb) {
      return write<T>(callback);
    } else {
      return writeAsync<T>(callback);
    }
  }
}
