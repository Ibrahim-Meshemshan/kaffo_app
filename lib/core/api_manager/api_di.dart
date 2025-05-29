import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_manager.dart';

@module
abstract class DioInjection {
  @Singleton()
  Dio injectDio() {
    var dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        // هنا تضيف الـ headers
        headers: {
          'Authorization':
              'Bearer   eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI2Z3Vob3F1QXBqemxpcjdBLXFmblROWmNGRGhiRzltY2haN3NsN3pnem40In0.eyJleHAiOjE3NDg1MjY3NzMsImlhdCI6MTc0ODUyNTg3MywiYXV0aF90aW1lIjoxNzQ4NTI0OTczLCJqdGkiOiI0Mjc4ODM4Ni1kMTJkLTQ2MzgtOTljNy0yMjNhYjJiNmQyNjYiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiIyMTJlMjZmZC02NjVhLTQ1OWMtYmU2MS01NDRkYjUwOTFjZTIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiN2I0N2ZlMGUtMmU3ZC00OGI5LTllMWYtYzEzZWMzMGUyYmQ2IiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJpYnJhaGltIG1lc2htZXNoYW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJpYnJhaGltQGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJpYnJhaGltIiwiZmFtaWx5X25hbWUiOiJtZXNobWVzaGFuIiwiZW1haWwiOiJpYnJhaGltQGdtYWlsLmNvbSJ9.jGZPGyDlxyHmVKDLz8q0DYZJY93dogT9ZrXzqU7HL_BbkojNm5VJo-USl7BOYrcDtlejR4fwH7PPbCa6-6323hd1HZjFhFHRdJoya5nc0xU8Q8ISDTRTaJ_XGbqH-eoRcpBKAHe8taIeBSoBtdLqrglB_0kE_xc75QPB_xqQuS3qSaROmjnj0Ik-RkXkxtmlgYtUkooNAu7GEeXHK6NsbmTL3rPiuOj47GjQ49_RyNNF3FsK92DiWYSQtjcU4uHgzxqL4WJAcOsh80HpXmHdDE9_V0SB4L6J8GXw6faTsqT6XTS2D-9g3tLlrRhvZqrv-5XsthKvGvlK8rFemUwY4w',
          'accept': '*/*',
          // 'Content-Type': 'application/json',
        },
      ),
    );

    return dio;
  }

  @Singleton()
  RestClient injectRestClient(Dio dio) {
    // تأكد من أن الـ baseUrl هنا يطابق الـ baseUrl في @RestApi
    return RestClient(dio, baseUrl: 'http://localhost:8080/api/v1/');
  }
}