// Network-related exceptions
import '../models/erorr_data.dart';

class NetworkError implements Exception {
  final String message;
  NetworkError(this.message);

  @override
  String toString() => message;
}

class TimeoutError implements Exception {
  final String message;
  TimeoutError(this.message);

  @override
  String toString() => message;
}

class BadCertificateError implements Exception {
  final String message;
  BadCertificateError(this.message);

  @override
  String toString() => message;
}

// Server-related exceptions
class ServerError implements Exception {
  final ErrorModel errorModel;
  ServerError(this.errorModel);

  @override
  String toString() => errorModel.message ?? "Server error occurred";
}

// Client-related exceptions
class ClientError implements Exception {
  final ErrorModel errorModel;
  ClientError({required this.errorModel});

  @override
  String toString() => errorModel.message ?? "Client error occurred";
}

class UnauthorizedError implements Exception {
  final ErrorModel errorModel;
  UnauthorizedError(this.errorModel);

  @override
  String toString() => errorModel.message ?? "Unauthorized access";
}

class ForbiddenError implements Exception {
  final ErrorModel errorModel;
  ForbiddenError(this.errorModel);

  @override
  String toString() => errorModel.message ?? "Access forbidden";
}

class NotFoundError implements Exception {
  final ErrorModel errorModel;
  NotFoundError(this.errorModel);

  @override
  String toString() => errorModel.message ?? "Resource not found";
}

class ConflictError implements Exception {
  final ErrorModel errorModel;
  ConflictError(this.errorModel);

  @override
  String toString() => errorModel.message ?? "Conflict occurred";
}

class ValidationError implements Exception {
  final ErrorModel errorModel;
  ValidationError(this.errorModel);

  @override
  String toString() => errorModel.message ?? "Validation failed";
}

// Other exceptions
class RequestCancelledError implements Exception {
  final String message;
  RequestCancelledError(this.message);

  @override
  String toString() => message;
}

class UnknownError implements Exception {
  final String message;
  UnknownError(this.message);

  @override
  String toString() => message;
}