sealed class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

final class NetworkException extends AppException {
  const NetworkException(super.message);
}

final class ServerException extends AppException {
  const ServerException(super.message);
}

final class NoDataException extends AppException {
  const NoDataException(super.message);
}
