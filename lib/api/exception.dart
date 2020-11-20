class APIException implements Exception {
  final int httpStatus;
  final int errorCode;
  final String errorMessage;

  APIException({
    this.httpStatus,
    this.errorCode,
    this.errorMessage,
  });
}