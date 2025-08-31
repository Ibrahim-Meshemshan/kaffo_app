import '../error_handler/failure.dart';

sealed class ApiResult<T> {}

class ApiSuccessResult<T> extends ApiResult<T> {
  T? data;

  ApiSuccessResult(this.data);
}

class ApiErrorResult<T> extends ApiResult<T> {
  Failures failures;

  ApiErrorResult(this.failures);
}
