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


  static const String token = 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJqVWJHZGdnVzI4aFFmRW9PWl8zN0FGMk92U0JJX19sdFpHbGswdzBmYXMwIn0.eyJleHAiOjE3NTc0MTczMzcsImlhdCI6MTc1NzQxNjQzNywiYXV0aF90aW1lIjoxNzU3NDE1Nzk5LCJqdGkiOiIyNzgzNjIxZS1kYjhmLTRmN2MtOWVkOC0xNjkwMDFmYzhmNGQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI0YWI4ZTNjNi03M2MwLTQ4YzctOWVkZS0wNDI4NWVlZWQwYTciLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiMjJkMzM3ODktMzJlMC00ZTZjLTk1N2ItNzI1ZDYzNjY3NzYzIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJpYnJhaGltIGFiZCIsInByZWZlcnJlZF91c2VybmFtZSI6ImlicmFfbW5AZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImlicmFoaW0iLCJmYW1pbHlfbmFtZSI6ImFiZCIsImVtYWlsIjoiaWJyYV9tbkBnbWFpbC5jb20ifQ.T2FxL6DCIsFMQn94xjAIJWpLoJbSsddgJ8qPgbvynY2NQW4VEoITEOoIMOn1UpybSq6m5ar1zWc46qnObEIwUkAHhkVWB-ZaClgT4hdmVqtUsIoNgEAdTWiSSJbg0KDPNoez2A_pj0E9RHBUc6HSO_apMRP9RDSn60NUNLyD1FyL-XTIHNSZLhRPsSPIAG8gUk9afUg1bOCdAmZAFpfeZIfLvkKrF5zuWQU5IdFBWlqObEXF1Nxr3iiFbodaMAvw4msHaQthstBKEC7JANCghqfYdGDUjXI1CdWXiJZxquMGyYe3sIaKVVkeQDGUMdGMREHlZ1GS3dvT1YdqryPVxw';
  @Singleton()
  Dio provideDIO(LogInterceptor logInterceptor) {

    var dio = Dio(  BaseOptions(
      validateStatus: (_)=>true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
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