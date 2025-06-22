import '../error_handler/error_handler.dart';
import '../exceptions/exceptions_impl.dart';
import '../models/erorr_data.dart';
import '../models/result.dart';
import 'package:dio/dio.dart';

// class ApiExecute {
//   static Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
//
//     try {
//       var result = await apiCall.call();
//       return Success(result);
//     } on DioException catch (ex) {
//       switch (ex.type) {
//         case DioExceptionType.badCertificate:
//         case DioExceptionType.connectionError:
//         case DioExceptionType.sendTimeout:
//         case DioExceptionType.receiveTimeout:
//         case DioExceptionType.connectionTimeout:
//           {
//             return Error(NetworkError("Check your internet connection"));
//           }
//         case DioExceptionType.badResponse:
//           {
//             var responseCode = ex.response?.statusCode ?? 0;
//             print("⚠️ DioExceptionType.badResponse");
//             print("StatusCode: $responseCode");
//             print("Response data: ${ex.response?.data}");
//
//             try {
//               var errorModel = ErrorModel.fromJson(ex.response?.data);
//               if (responseCode >= 400 && responseCode < 500) {
//                 return Error(ClientError(errorModel: errorModel));
//               }
//               if (responseCode >= 500 && responseCode < 600) {
//                 return Error(ServerError(errorModel));
//               }
//             } catch (e) {
//               print("❌ Error while parsing errorModel: $e");
//             }
//
//             return Error(Exception("Something went wrong"));
//           }
//         default:
//           {
//             return Error(Exception("Something went wrong"));
//           }
//       }
//     } on Exception catch (ex) {
//       return Error(ex);
//     }
//   }
// }
class ApiExecute {
  static Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
    try {
      var result = await apiCall.call();
      return Success(result);
    } catch (error) {
      final exception = ErrorHandler.handleError(error);
      return Error(exception);
    }
  }
}