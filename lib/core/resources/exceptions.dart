class ServerException implements Exception {
  final String message;
  const ServerException({this.message = "Unknown server error!"});
}

class LocalException implements Exception {
  final String message;
  const LocalException({this.message = "Unknown local error!"});
}
