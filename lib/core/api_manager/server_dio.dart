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
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIwMTk4ZDZlOC1hZDQ1LTczYWYtYjMxZS01MzQwNmE5MzcwZmYiLCJqdGkiOiI4MzU4M2E3ZDY4OGU2ZGJkMmY1YmU0YmU4NjI3NDIyMWQ0OGQxNWU3MTk0NDNkMzA3NjA4MWUzNWQ2NWM0NThkNTYyMTUzMTZjZjQ4MThmNiIsImlhdCI6MTc1NjQ4ODkzNy4wMDYyNzksIm5iZiI6MTc1NjQ4ODkzNy4wMDYyOCwiZXhwIjoxNzU2NDg5ODM3LjAwMTc2OSwic3ViIjoiMDE5OGQ3NWItODdmMC03MTk1LTkwOTYtYzc4ZGIwMmRmYTg0Iiwic2NvcGVzIjpbXX0.fJE8TFG5uvq_fnN8hYj_jzWHaj7W2XgHoNJdSqsJJr6fK5TJmn4jFfEUQBcyXlXBShsGCUEdHa0nHsEJbZN8oRNWqYgjLVuh5q_3CXsBr5H-r4RosRKzDlY4ZO0CXjf4flj5R_N-PcFecuAmY6KfUuRJTpvqs9j_pMDvztbD6p_RSecRlD62T6TTnbHwzjMNmt5kYF7LRoTh2bSY6wE46PSBxH3sjVSufFFBe1VxEJEimmXoDZ_NxxcBe6qDRe6gS3dpXH6VcnfdOldrGhK8a9oiTS26tntWtYi9JJvgh_2hxY4gxk_60EgVqc0URFC80iDLROStP3N_gsXRBhYp7Kz5fjxWp1D2TcgwGH5oh0aVbn79msv40lmEviGNeHJTY_gMB8EqBf0tkt_bKZcxVubNJRE9Isyv8Sg60mV5NyzDa1w-thwq2Ibwb0L50l3VTUZrIOEQaFRwPIf_1RVdabELj4qMLdvgg7rCrxZOHEEHL9zPDPFh6sLqxZp0zdODTTEBfJ18xBzCTplrrZP3LhR9u5znUuY_yR-e9T3mOllOlcmm5SsRCnIQS9YMRdPySSVLOQxvm639OV7WHF4PtnbLITmH4V0Hk8aTYXNLMXT_w4GSJv_UARZpcO7_GZTIcLdwMm21m9elknmkpsKmvfD8SSKtKYq4qfJBXlGFsxw'
        },
        followRedirects: true,
      ),
    );
    addDioInterceptor();
    addCheckRefreshDioInterceptor();
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


  static void addCheckRefreshDioInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // get token from cash before request
          final accessToken = SharedPreferencesHelper.getToken();
          if (accessToken != null ) { // && options.headers['Authorization'] == null
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = SharedPreferencesHelper.getRefreshToken();

            if (refreshToken != null) {

              // final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

              try {

                final response = await _dio.post(
                  'ApiConstant.refreshToken,',

                  data: {'refresh_token': refreshToken},
                );

                if (response.statusCode == 200) {
                  final newAccessToken = response.data['access_token'];
                  final newRefreshToken = response.data['refresh_token'];
                  await SharedPreferencesHelper.saveToken(newAccessToken);
                  await SharedPreferencesHelper.saveRefreshToken(newRefreshToken);

                  error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

                  final clonedRequest = await _dio.request(
                    error.requestOptions.path,
                    options: Options(
                      method: error.requestOptions.method,
                      headers: error.requestOptions.headers,
                    ),
                    data: error.requestOptions.data,
                    queryParameters: error.requestOptions.queryParameters,
                  );

                  return handler.resolve(clonedRequest);
                }
              } catch (e) {

                log('Failed to refresh token: $e');

                return handler.next(e as DioException);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

}