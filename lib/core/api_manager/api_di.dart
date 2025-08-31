import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/api_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


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
        "Authorization":"Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJqVWJHZGdnVzI4aFFmRW9PWl8zN0FGMk92U0JJX19sdFpHbGswdzBmYXMwIn0.eyJleHAiOjE3NTY2MTYzNTgsImlhdCI6MTc1NjYxNTQ1OCwiYXV0aF90aW1lIjoxNzU2NjEzMzE2LCJqdGkiOiI3ZDhhZTAxNy1mZjI3LTQxMWItYTMzZS0xMWNiNzEwYTJlYjAiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI3ZjE0OTIyYS0xYjE1LTRlZTYtYTlkOC03MzczODdkYzFkYWMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiNGM0MDQzODUtOWE4Yy00NTIwLWJiODctODVmY2E2M2Q3NTdmIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJpYnJhaGltIG1uIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaWJyYWhpbUBnbWFpbC5jb20iLCJnaXZlbl9uYW1lIjoiaWJyYWhpbSIsImZhbWlseV9uYW1lIjoibW4iLCJlbWFpbCI6ImlicmFoaW1AZ21haWwuY29tIn0.OMuz-xVmIq6ESc8DII5wfit_pqfkkOi8MDE8O8CIUKzUyusVPOaRSKsYWq1twIJMTUMdu2gBTbaJJOD_k7ZtUJuXvS6yL59cLRxvmnlgkb56F5By6W0pOUZIebcqW7Ot5ZE5pW7bvJhLNNBgPnzC5iyB8-oEr_RXLf3Xlg1y-Y-iPvCcaxgOHWotSZd68gcakDzWAwfA8eoEWdK5Xd9Xr_2LmiXoLxpi_g5DvWCdPfszD5FKkYccrjZ-5-Onr5KapwqaCG7srlzLFyM-aSWpdHRoWN4aZgO5bLz-va1Rzyr17MV8Kic4ldr9yCWQXsoNPvzqOpTlh6Wns2_MZnSQSQ"
      },
    ),);

    // customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args){
          if(options.path.contains('/posts')){
            return false;
          }
          return !args.isResponse || !args.hasUint8ListData;
        }
    )
    );
    return dio;

  }

  @Singleton()
  RestClient provideWebServices(Dio dio) {
    return RestClient(dio);
  }
}