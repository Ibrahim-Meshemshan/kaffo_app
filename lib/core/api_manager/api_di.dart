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
        "Authorization":"Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJPODcyQTJBOXFNaTdfS1U3NjFUM1ZrVTk5MXR1Um1lX3FZb3lseXdybkJvIn0.eyJleHAiOjE3NTI1NjQ5NjYsImlhdCI6MTc1MjU2NDA2NiwiYXV0aF90aW1lIjoxNzUyNTU2ODI5LCJqdGkiOiI3ZTg3N2NmMi0zOGQ0LTQ3OGMtOTMyOS1mYmZjZTgyYWViYmQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiJjMzM2YzcyZS03OWEzLTQ3NzAtOTI5Ny00NTcxZjFjZDQ1MTgiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiYzMyMGQzYmMtMmJiNi00OTIzLWIxNTEtNGFhOTMxM2QwZDZlIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJhcyBhYWEiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJpYnJhaGltQGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJhcyIsImZhbWlseV9uYW1lIjoiYWFhIiwiZW1haWwiOiJpYnJhaGltQGdtYWlsLmNvbSJ9.pq7d3fVPndUKLMrTnxAZob7NeMco1MO8-AAdxXhkJkpwrrRyJDQQ3qFDd7ZrVZc-mKx93xezHjBQYSDaeBVRp6NXcIQaDlXtfca-IEjLRLe56Jb8GnUMk-IiGZGmjj1lKZWzVxFMWAL2dtaC0RIAT3iP2tl9pL95_nm4OLOoYWWG46RijIBqQRTye_x48Dbby5P1uhayL_DctUMOgQhvOrNZVAxRiLRigeYNy6c7N7vBgCyBC5r2HmvL2iomTnrhZO4lq6sSzkvQF-PMDiE7wOsXkXN6urW0w3HO2ZxOIySVgHBJ8q0UTrbqeN66MqdLniVyGfUI0mCjymCW2HH-0w"
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