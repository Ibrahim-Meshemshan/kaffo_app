// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:kaffo/core/api_manager/api_manager.dart';
// import 'package:kaffo/core/api_manager/auth_manager.dart';
//
//
// @module
// abstract class DioInjection {
//
//   @Singleton()
//   LogInterceptor provideLogger() {
//     return LogInterceptor();
//   }
//
//   @Singleton()
//   Dio provideDIO(LogInterceptor logInterceptor) {
//
//     var dio = Dio(  BaseOptions(
//       validateStatus: (_)=>true,
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//       headers: {
//         "accept": "*/*",
//         "Content-Type": "application/json",
//         "Authorization":"Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ1ZjdPbmJJMTVxOFVDWFhEU0daYUF2NkMwcmMzNUYtZFdESmticV93UjFBIn0.eyJleHAiOjE3NTc0MTY2NzksImlhdCI6MTc1NzQxNTc3OSwiYXV0aF90aW1lIjoxNzU3NDE0Nzk0LCJqdGkiOiI5Y2Q0Yzc5Yi00MDdmLTQ4OGEtOThkYi1iZGY4NmZiYTUyZmQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiJiZmFhOGY1Ni01MWJlLTRmZTgtYjYzOC0yZDE5NTAxZGE4ZDMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiZTJmYjI3OGMtY2I4Ni00YzAzLTg1MTgtMmVkMjM4NzhlYWQ4IiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJEQVMgREFTIiwicHJlZmVycmVkX3VzZXJuYW1lIjoic0BnbWFpbC5jb20iLCJnaXZlbl9uYW1lIjoiREFTIiwiZmFtaWx5X25hbWUiOiJEQVMiLCJlbWFpbCI6InNAZ21haWwuY29tIn0.V48r1FXwy-3F7Yk3TLjBLaLjgL3yiYg_-7hDPrj2KQivKkg0sg4ZomaclOXYgs0xiGwDnxcI5ZwdUbMxmC5iIouMA2PUwCTtZ3FjNVY5Ll8-i4To_jX_qygBkHsQL_QLlvw-ZQDmYzAkIuTtn3cZrqP70wuA5POggchzu9aYymQEr2IT9Bybsh2DXrM9-fUKsjBiApw38pcPBwsvMZgNjU-bdwgTefLy58HSr0D7Gla9AB3bqBFC6RtqjTtRSRw6l28P2OqTsUCUqq9-LkimPrRPAqOcl_iMEa2jWavudh7DVdDUN184lJCoYlaibH6UGf6SGAvX9aNzinFRxzcdQA"
//       },
//     ),);
//
//     dio.interceptors.add(logInterceptor);
//     return dio;
//   }
//
//   @Singleton()
//   RestClient provideWebServices(Dio dio) {
//     return RestClient(dio);
//   }  AuthClient provideRestClient(Dio dio) => AuthClient(dio);
//
// }


import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kaffo/core/api_manager/api_manager.dart';
import 'package:kaffo/core/api_manager/auth_manager.dart';

@module
abstract class DioInjection {
  // Secure storage instance
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @Singleton()
  LogInterceptor provideLogger() {
    return LogInterceptor(
      requestBody: true,
      responseBody: true,
    );
  }

  @Singleton()
  Dio provideDIO(LogInterceptor logInterceptor) {
    var dio = Dio(
      BaseOptions(
        validateStatus: (_) => true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
        },
      ),
    );

    // Attach token from secure storage dynamically
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.read(key: "access_token");
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          handler.next(options);
        },
        onError: (DioError e, handler) {
          // Optional: handle errors globally
          print("Dio Error: ${e.response?.statusCode} -> ${e.message}");
          handler.next(e);
        },
      ),
    );

    dio.interceptors.add(logInterceptor);
    return dio;
  }

  @Singleton()
  RestClient provideWebServices(Dio dio) {
    return RestClient(dio);
  }

  AuthClient provideRestClient(Dio dio) => AuthClient(dio);
}
