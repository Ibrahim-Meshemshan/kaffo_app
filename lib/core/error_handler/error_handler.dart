import 'package:dio/dio.dart';
import '../exceptions/exceptions_impl.dart';
import '../models/erorr_data.dart';
import 'exception_impl.dart';

class ErrorHandler {
  static Exception handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is Exception) {
      return error;
    } else {
      return UnknownError("An unknown error occurred");
    }
  }

  static Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutError("Request timed out. Please try again.");

      case DioExceptionType.badCertificate:
        return BadCertificateError("Invalid security certificate");

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return RequestCancelledError("Request was cancelled");

      case DioExceptionType.connectionError:
        return NetworkError("No internet connection");

      default:
        return NetworkError("Network error occurred");
    }
  }

  static Exception _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    // Log the error for debugging
    _logError(statusCode, responseData);

    try {
      if (responseData != null) {
        final errorModel = ErrorModel.fromJson(responseData);
        return _createAppropriateError(statusCode, errorModel);
      }
    } catch (e) {
      print("Error parsing error response: $e");
    }

    return _getGenericError(statusCode);
  }

  static void _logError(int? statusCode, dynamic responseData) {
    print("⚠️ API Error:");
    print("Status Code: $statusCode");
    print("Response Data: $responseData");
  }

  static Exception _createAppropriateError(int? statusCode, ErrorModel errorModel) {
    if (statusCode == null) {
      return UnknownError(errorModel.message ?? "Unknown error");
    }

    if (statusCode >= 400 && statusCode < 500) {
      if (statusCode == 401) {
        return UnauthorizedError(errorModel);
      } else if (statusCode == 403) {
        return ForbiddenError(errorModel);
      } else if (statusCode == 404) {
        return NotFoundError(errorModel);
      } else if (statusCode == 409) {
        return ConflictError(errorModel);
      } else if (statusCode == 422) {
        return ValidationError(errorModel);
      } else {
        return ClientError(errorModel: errorModel);
      }
    } else if (statusCode >= 500) {
      return ServerError(errorModel);
    }

    return UnknownError(errorModel.message ?? "Unknown error");
  }

  static Exception _getGenericError(int? statusCode) {
    if (statusCode == null) {
      return UnknownError("Unknown error occurred");
    }

    if (statusCode >= 400 && statusCode < 500) {
      return ClientError(errorModel: ErrorModel(message: "Client error occurred"));
    } else if (statusCode >= 500) {
      return ServerError(ErrorModel(message: "Server error occurred"));
    }

    return UnknownError("An error occurred with status code: $statusCode");
  }
}