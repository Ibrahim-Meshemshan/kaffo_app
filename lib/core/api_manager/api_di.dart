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


  static const String token = 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJaNnE4MGZOQ0ZMcXFFT1pCN2hBdHg2aU9FdUZjUmNjZjh1YjlKWTNOV3RnIn0.eyJleHAiOjE3NTc0NDQ4MTEsImlhdCI6MTc1NzQ0MzkxMSwiYXV0aF90aW1lIjoxNzU3NDQzOTExLCJqdGkiOiJkNjAyYWNmNC01ZjZlLTRiYjUtYTkzZC03ZGYzZTA5YzJjZDciLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI1ZmU4OGQwNC1mODA2LTRiMDQtYTZjOS0xN2IzMWY2NzlhNTYiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiNjk1NzViNzMtNTE4ZC00ZDRiLTlmMmMtOTdhMjhkYzc4ZTVhIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJpYnJhaGltIGFiZCIsInByZWZlcnJlZF91c2VybmFtZSI6InNhbWlyQGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJpYnJhaGltIiwiZmFtaWx5X25hbWUiOiJhYmQiLCJlbWFpbCI6InNhbWlyQGdtYWlsLmNvbSJ9.S5O02Wyxj9dRNy1f3jHUakN3XzCKwnD5q3G35QNJ24BfOqNTA1jH-0D_QFAILgodIMqFQ__GqKDN1XoqhOMhvsq2mOJUCDT1e4QjSjvWruX6TM2ZM4VVthU5Ts_ZEZDkPNwGhKOO9zudNJcVKYhVisfSBqkrR4FuiSV1UgwSLT2-LwBmoWpOaEy5sGW0l1U7ktq_tZ8U9ddAMTj91BNC3g3_cv67xETuoxoAYT0VzL3KiuE-Gqth2jfUrh3Og7b40yPpqS_vsNF8LXb57Tydk65NO2C7IQRQkZpZMoKnvD627qLKK4RXgJNKkdrvY_CxzxhtV0u9VbuZ3thxNN-VLw';
  @Singleton()
  Dio provideDIO(LogInterceptor logInterceptor) {

    var dio = Dio(  BaseOptions(
      validateStatus: (_)=>true,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": token
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