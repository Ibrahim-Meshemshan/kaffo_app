// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:kaffo/core/app_consts/api_constant.dart';
//
// import 'api_manager.dart';
//
// @module
// abstract class DioInjection {
//   @Singleton()
//   Dio injectDio() {
//
//     var dio = Dio(
//
//       BaseOptions(
//         connectTimeout: const Duration(seconds: 60),
//         // هنا تضيف الـ headers
//         headers: {
//           // 'Authorization':
//           //     'Bearer   eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJYZjRpUHhmYWhfbldSX20zNTdTdWZ0U09SN1Q5TWd0NEpKREgxZ1VqWmswIn0.eyJleHAiOjE3NDg4MDI2OTAsImlhdCI6MTc0ODgwMTc5MCwiYXV0aF90aW1lIjoxNzQ4ODAwODA4LCJqdGkiOiJhOWQ4NDdjOS1iMWIxLTRiMmItOWM1My0wNjU2MWM4MDM3YzMiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI2NzI5MDhkZi02ZDExLTQ0NjQtYmY0OS1mYzUxN2RjYjFjMGIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiZDhiYjljNjYtMGIyNS00YmE1LTk3YjktYTk4YTNkNjdiNTVkIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJhc2QgYXNkIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaGVrbWF0QGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJhc2QiLCJmYW1pbHlfbmFtZSI6ImFzZCIsImVtYWlsIjoiaGVrbWF0QGdtYWlsLmNvbSJ9.GoTjK1-elg_TUKwXO-UX8ioYCQ8MdJI0uW9N1_5P6kC5Ch4vOo1GsebUg-4y76e5Pd_BwnRKJY6BACKx9Rmc4hgNeh1vm5ID7-gF8aUmO05hHDRQbB2RBmrwO1D4J5zW6uoenN880XenDKN44sElf34CWabQ0Vynx5KSXba22__19YUBhD19IZrc7p5avytFvfZRYNFs-62y_R6J7kN1lhuybfZqKNzS4NTdfdTCaSxeYSboXz63ZoPMKB8TCuiNCo-fjerfJlu4bMDVTcd-Yzzo78wkbPRsrNhBClP6vGZMFSi-69R9ORz-oKWfs8q83LR4QBbiGUOjtLvepNCV3g',
//           'accept': '*/*',
//           // 'Content-Type': 'application/json',
//         },
//       ),
//     );
//     dio.interceptors.add(LogInterceptor(
//       request: true,
//       responseBody: true,
//       error: true,
//       requestHeader: true,
//       responseHeader: true,
//     ));
//
//     return dio;
//   }
//
//   @Singleton()
//   RestClient injectRestClient(Dio dio) {
//     // تأكد من أن الـ baseUrl هنا يطابق الـ baseUrl في @RestApi
//     return RestClient(dio, baseUrl: ApiConstant.baseUrl);
//   }
// }

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
        "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJPODcyQTJBOXFNaTdfS1U3NjFUM1ZrVTk5MXR1Um1lX3FZb3lseXdybkJvIn0.eyJleHAiOjE3NTA2MTI3NzMsImlhdCI6MTc1MDYxMTg3MywiYXV0aF90aW1lIjoxNzUwNjA4MjkyLCJqdGkiOiI1MjZkNDVlMS04OTc4LTRmN2EtOTJiOC1mNzcxMjIyNTgxNDkiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiJjMzM2YzcyZS03OWEzLTQ3NzAtOTI5Ny00NTcxZjFjZDQ1MTgiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiY2JkZmUxOTctY2Y5Ni00Y2FkLTkzOTctOTgyYTNkNTg0ZmJhIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJhcyBhYWEiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJpYnJhaGltQGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJhcyIsImZhbWlseV9uYW1lIjoiYWFhIiwiZW1haWwiOiJpYnJhaGltQGdtYWlsLmNvbSJ9.LJ1Xk8uNMAVpOzOZ7QknC7kiBe8JpTxIgmHGMNLEfyohDwB4J6hH0WbsOrxK3uWtwKaEphuGphwDvf30gPe4NpaWyQhsiSP27x1y-maCjFeKkjDGXll7KdCMsjnh0E7uYTwnKM8khcMVn3-6Rzo8y891yXyQpcGozWWnA1_nRzUJ-lIBQp7qZDcSu5K9hXCWpHvjeJORI3sWksMW4dZ4sQ74iIMMuez4DDpb_BwbF__QAmV2ihKddYAvpkvrl4fmglfKBknT3B8EETUUuyC95PpAZmGR-yrKu6tFtHVsSaDIRWZ-ebeUde-FZhA4asFMeU82tTgqahVcGBfk0k7X4g"
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