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
        "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ1ZjdPbmJJMTVxOFVDWFhEU0daYUF2NkMwcmMzNUYtZFdESmticV93UjFBIn0.eyJleHAiOjE3NTMwMTI3NjYsImlhdCI6MTc1MzAxMTg2NiwiYXV0aF90aW1lIjoxNzUzMDExODY1LCJqdGkiOiJkOWM2NDE3MC1lZmVjLTQ2MjctYWMzNi0yYTE2MTQ3MzAwMGQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI4MGU1NGYxNS02NTA0LTRlMjUtODA1Zi1mZWZjZTc1NDg2ZGQiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiYjU5MzE4YmYtNjNjZi00YWQxLTk1OTYtZmEyYTUxYzBmMDA2IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJIIEYiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJoZWttYXRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6IkgiLCJmYW1pbHlfbmFtZSI6IkYiLCJlbWFpbCI6Imhla21hdEBnbWFpbC5jb20ifQ.lgHsf3rODOZe1IBvr4JvMi_jbvsNSUGc9u09_Thye1aMnfJQ7wSbXOQ2ZYRXuoDO0KGDc4xjAB6fS0H4Qf-2GTcZj0HfRzK9ZQl4G1ISzY5ytGSyqh2DJpDyg6na5l-MMkDZpqiI-UEtB496sX82YIvlb9SDsV7IECVs_6nr3X_z3q9TGk6siDLeX_wU8RwbVE1hDpkb2DON6-_z56KPPxzeAIH53k8EOcsvjn6S21R-UldeiCIuVWPncFkHkKACFMyv3OUpeXgBoId39SSnDwW2N0nBVPluucN58jHqf4zRNAWdnSV3XMcEuUp_-lVptWmVEgWQ3Zj7ygfvb5zk9w"
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