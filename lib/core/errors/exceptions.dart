class ServerException implements Exception {
  const ServerException(this.message);
  final String message;
}

class CacheException implements Exception {
  const CacheException([this.message = 'Cache error occurred']);
  final String message;
}
