import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      // error from client
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: 'No internet connection');
        case DioExceptionType.cancel:
          return ApiErrorModel(message: 'Request to the Server was cancelled');
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: 'Connection timeout with API server');
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: 'Send timeout in connection with API server',
          );
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401) {
            return ApiErrorModel(message: 'Unauthorized, Login again');
          } else if (statusCode == 403) {
            return ApiErrorModel(message: 'You don\'t have permission');
          } else if (statusCode == 400) {
            return ApiErrorModel(message: 'Bad request');
          } else if (statusCode! >= 500) {
            return ApiErrorModel(message: 'Internal server error');
          }
          return _handleError(error.response?.data);
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: 'Receive timeout in connection with API server');
        case DioExceptionType.unknown:
          log('Unknown DioError: ${error.error}');
          return ApiErrorModel(message: 'Something went wrong');
        default:
          return ApiErrorModel(message: 'Something went wrong');
      }
    } else {
      // default error
      if (error is FormatException) {
        return ApiErrorModel(message: "Bad response format");
      }
      if (error is SocketException) {
        return ApiErrorModel(message: 'No internet connection');
      }
      return ApiErrorModel(message: 'Something went wrong');
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  return ApiErrorModel(
    message: data['message'] ?? 'Something went wrong',
    code: data['code'],
    errors: data['errors'],
  );
}
