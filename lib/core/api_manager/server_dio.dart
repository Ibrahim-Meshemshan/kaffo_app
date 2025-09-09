import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kaffo/core/api_manager/api_di.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import 'api_constant.dart';
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
          'Authorization': DioInjection.token
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