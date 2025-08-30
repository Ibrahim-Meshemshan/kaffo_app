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
        "Authorization":"Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJqVWJHZGdnVzI4aFFmRW9PWl8zN0FGMk92U0JJX19sdFpHbGswdzBmYXMwIn0.eyJleHAiOjE3NTY1NTQyMjgsImlhdCI6MTc1NjU1MzMyOCwiYXV0aF90aW1lIjoxNzU2NTQ4MjQ1LCJqdGkiOiI2MzA1OGE0MC1jYzg5LTQwNzQtYWU2Zi1iZDM4ZmEwOWJmZjYiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI3ZjE0OTIyYS0xYjE1LTRlZTYtYTlkOC03MzczODdkYzFkYWMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiYjZhY2ZmNTgtMjIyNC00Y2YzLTkwN2MtZTQ5N2YxNjc1NzFlIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJpYnJhaGltIG1uIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaWJyYWhpbUBnbWFpbC5jb20iLCJnaXZlbl9uYW1lIjoiaWJyYWhpbSIsImZhbWlseV9uYW1lIjoibW4iLCJlbWFpbCI6ImlicmFoaW1AZ21haWwuY29tIn0.Ci0qoeXFWJEiNA7Ds9wS0adJv1-sri4nK9eunhlE8P7ntoaN8KEgM8HQJxZ_s3JaEpIauJQyeIYZHUtx2NIUegauRULXO4ngmngkTKIjTZJCQLUgAecPaWyGlnxNcEJw02gb86stGFJfazADp0APUGnJkFMnY-tV-tNZo_we6Z3ou7d85PNKR_b3iej4vRQBH-X-QNLB_Vr2wNSJurQLCJETLc27GEMyujRl5HIwtc66vWzGM0cwei0aCL1tiHLRxkymlsT2p9ygqx8jhIgd4lSUdMzGAmv8L2B23j4nSI9yb-YjyxiheWMdTQsn6vz7thJdVfuxAef_ZZkobaEj7w"
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