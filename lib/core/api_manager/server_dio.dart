import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import '../app_consts/api_constant.dart';
import '../storage/sharedprfrences_helper.dart';

class ServerDio {
  static late Dio _dio;

  static Dio get dioInstance => _dio;

  static void initDio() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
        baseUrl: ApiConstant.baseUrl,
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJqVWJHZGdnVzI4aFFmRW9PWl8zN0FGMk92U0JJX19sdFpHbGswdzBmYXMwIn0.eyJleHAiOjE3NTY2MTYzNTgsImlhdCI6MTc1NjYxNTQ1OCwiYXV0aF90aW1lIjoxNzU2NjEzMzE2LCJqdGkiOiI3ZDhhZTAxNy1mZjI3LTQxMWItYTMzZS0xMWNiNzEwYTJlYjAiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI3ZjE0OTIyYS0xYjE1LTRlZTYtYTlkOC03MzczODdkYzFkYWMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiNGM0MDQzODUtOWE4Yy00NTIwLWJiODctODVmY2E2M2Q3NTdmIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJpYnJhaGltIG1uIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaWJyYWhpbUBnbWFpbC5jb20iLCJnaXZlbl9uYW1lIjoiaWJyYWhpbSIsImZhbWlseV9uYW1lIjoibW4iLCJlbWFpbCI6ImlicmFoaW1AZ21haWwuY29tIn0.OMuz-xVmIq6ESc8DII5wfit_pqfkkOi8MDE8O8CIUKzUyusVPOaRSKsYWq1twIJMTUMdu2gBTbaJJOD_k7ZtUJuXvS6yL59cLRxvmnlgkb56F5By6W0pOUZIebcqW7Ot5ZE5pW7bvJhLNNBgPnzC5iyB8-oEr_RXLf3Xlg1y-Y-iPvCcaxgOHWotSZd68gcakDzWAwfA8eoEWdK5Xd9Xr_2LmiXoLxpi_g5DvWCdPfszD5FKkYccrjZ-5-Onr5KapwqaCG7srlzLFyM-aSWpdHRoWN4aZgO5bLz-va1Rzyr17MV8Kic4ldr9yCWQXsoNPvzqOpTlh6Wns2_MZnSQSQ'
        },
        followRedirects: true,
      ),
    );
    addDioInterceptor();
    // addCheckRefreshDioInterceptor();
  }


  static void addDioInterceptor() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        enabled: kDebugMode,
        error: true,
      ),
    );
  }


  // static void addCheckRefreshDioInterceptor() {
  //   _dio.interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) async {
  //         // get token from cash before request
  //         final accessToken = SharedPreferencesHelper.getToken();
  //         if (accessToken != null ) { // && options.headers['Authorization'] == null
  //           options.headers['Authorization'] = 'Bearer $accessToken';
  //         }
  //         return handler.next(options);
  //       },
  //       onError: (error, handler) async {
  //         if (error.response?.statusCode == 401) {
  //           final refreshToken = SharedPreferencesHelper.getRefreshToken();
  //
  //           if (refreshToken != null) {
  //
  //             // final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  //
  //             try {
  //
  //               final response = await _dio.post(
  //                 'ApiConstant.refreshToken,',
  //
  //                 data: {'refresh_token': refreshToken},
  //               );
  //
  //               if (response.statusCode == 200) {
  //                 final newAccessToken = response.data['access_token'];
  //                 final newRefreshToken = response.data['refresh_token'];
  //                 await SharedPreferencesHelper.saveToken(newAccessToken);
  //                 await SharedPreferencesHelper.saveRefreshToken(newRefreshToken);
  //
  //                 error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
  //
  //                 final clonedRequest = await _dio.request(
  //                   error.requestOptions.path,
  //                   options: Options(
  //                     method: error.requestOptions.method,
  //                     headers: error.requestOptions.headers,
  //                   ),
  //                   data: error.requestOptions.data,
  //                   queryParameters: error.requestOptions.queryParameters,
  //                 );
  //
  //                 return handler.resolve(clonedRequest);
  //               }
  //             } catch (e) {
  //
  //               log('Failed to refresh token: $e');
  //
  //               return handler.next(e as DioException);
  //             }
  //           }
  //         }
  //         return handler.next(error);
  //       },
  //     ),
  //   );
  // }

}