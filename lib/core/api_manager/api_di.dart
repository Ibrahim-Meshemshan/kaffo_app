import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/api_manager.dart';


@module
abstract class DioInjection {

  @Singleton()
  LogInterceptor provideLogger() {
    return LogInterceptor();
  }

  @Singleton()
  Dio provideDIO(LogInterceptor logInterceptor) {

    var dio = Dio(  BaseOptions(
      validateStatus: (_)=>true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization":"Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJPODcyQTJBOXFNaTdfS1U3NjFUM1ZrVTk5MXR1Um1lX3FZb3lseXdybkJvIn0.eyJleHAiOjE3NTI2ODMyMjUsImlhdCI6MTc1MjY4MjMyNSwiYXV0aF90aW1lIjoxNzUyNjc3MDE1LCJqdGkiOiIzYWVmMWFjOC0wMDVhLTRmMGUtYjQ0Zi1mYzkwMmExZDhmZGYiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiJjMzM2YzcyZS03OWEzLTQ3NzAtOTI5Ny00NTcxZjFjZDQ1MTgiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiNWZhYTRiM2YtYzRhMy00ZmI2LWJkNDEtNzJlMDAwMmZhY2U2IiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJhcyBhYWEiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJpYnJhaGltQGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJhcyIsImZhbWlseV9uYW1lIjoiYWFhIiwiZW1haWwiOiJpYnJhaGltQGdtYWlsLmNvbSJ9.wNJCxY1Hnhmjp7b0V5C1ps1fXL_f4NVOgI7qDhThFthpdb4C7f9OUhNKttNIot5Rus6wBn_yH1qE0XGsdEAHZs6qp0Uwa7Ou7nKczO9GG91abjxIbcjb2icPdnM1MppL61HV3QNMoDkjO8goQ9UA9-NFElxuoYGiKYzNlI8Vw5ir2ZxKzf6wHpq8A7CXHquOFmpXsvlOqicOBPeDRSVcq5uGSXJkyKNU1EdraHZefSZYGLKBKrDCDYgjYXeiX_3DEpsT9kEG7Ly9UlVEvIzjcwwQ0NxDjcY8lNsvFWoNcph3hf5fsAXQZ4d5qRZRq9BEtpBp2vKsfdlVy-1qqWwXSA"
      },
    ),);

    dio.interceptors.add(logInterceptor);
    return dio;
  }

  @Singleton()
  RestClient provideWebServices(Dio dio) {
    return RestClient(dio);
  }
}