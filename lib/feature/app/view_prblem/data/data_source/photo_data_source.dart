import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/server_dio.dart';

import '../../../../../core/app_consts/api_constant.dart';
import '../model/photo_response_model.dart';
import '../model/presignd_url_response.dart';

@singleton
class PhotoDataSource {
  final Dio dio;

  PhotoDataSource(this.dio);

  Future<List<PhotoResponseModel>> getProblemPhotos(int problemId) async {
    final response = await ServerDio.dioInstance.get(
      '${ApiConstant.baseUrl}problem/$problemId/photos',
    );

    return (response.data as List)
        .map((photo) => PhotoResponseModel.fromJson(photo))
        .toList();
  }

  Future<List<PresignedUrlResponse>> getPresignedUrls(
      int problemId,
      int count, {
        String? contentType,
        int? progressId,
      }) async {
    final url = '${ApiConstant.baseUrl}problem/$problemId/photos';

    final queryParameters = {
      'count': count.toString(),
      if (contentType != null) 'contentType': contentType,
      if (progressId != null) 'progressId': progressId.toString(),
    };

    final response = await ServerDio.dioInstance.post(
      url,
      queryParameters: queryParameters,
    );

    return (response.data as List)
        .map((item) => PresignedUrlResponse.fromJson(item))
        .toList();
  }

  Future<void> uploadFileToS3(String presignedUrl, File file) async {
    final bytes = await file.readAsBytes();

    await ServerDio.dioInstance.put(
      presignedUrl,
      data: bytes,
      options: Options(
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJqVWJHZGdnVzI4aFFmRW9PWl8zN0FGMk92U0JJX19sdFpHbGswdzBmYXMwIn0.eyJleHAiOjE3NTY2MjAxMjEsImlhdCI6MTc1NjYxOTIyMSwiYXV0aF90aW1lIjoxNzU2NjEzMzE2LCJqdGkiOiIxNGQ1NmY1ZC1iYzI2LTRhMTktOGUwOC0yYjIwMTZlNTE1YmEiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjkwOTgvcmVhbG1zL2thZnUtcmVhbG0iLCJhdWQiOlsicmVhY3QtY2xpZW50IiwiYWNjb3VudCJdLCJzdWIiOiI3ZjE0OTIyYS0xYjE1LTRlZTYtYTlkOC03MzczODdkYzFkYWMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzcHJpbmctY2xpZW50Iiwic2lkIjoiNGM0MDQzODUtOWE4Yy00NTIwLWJiODctODVmY2E2M2Q3NTdmIiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vbG9jYWxob3N0OjgwODAvKiIsImh0dHA6Ly9sb2NhbGhvc3Q6ODA4MCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1rYWZ1LXJlYWxtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNwcmluZy1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJyZWFjdC1jbGllbnQiOnsicm9sZXMiOlsiUk9MRV9VU0VSIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJpYnJhaGltIG1uIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaWJyYWhpbUBnbWFpbC5jb20iLCJnaXZlbl9uYW1lIjoiaWJyYWhpbSIsImZhbWlseV9uYW1lIjoibW4iLCJlbWFpbCI6ImlicmFoaW1AZ21haWwuY29tIn0.gqtsOLUw6p4j6QwZOhxqPQx20WxrXtxBeebCD8TXX_9RaUFi3wOwb9fdoJ3_ASb8eZ7CJXTCoguGSUrrKITERyl8b3EEc9-iOiMDS9IMvstdVX3P0GpW-hcTKHac-DSwOPdwhAZhj5l1Jm9vpJLoyBmJVcbPmwMAT8LluH9IDXsq1mrYn09D8691W1B4wSmjBUuAH9DM42kZQatw7lvg7x7pwUlZPnHhxHh3dO5ahqt2NlCE1QAlwnJw62NTnnYSJCsXhawVlrrAtcSAMpqwn8gVZWNHWQd2X7wwds3u4Q3Vo-nqFjhv_EPwwOK7yISh2QduOlyWSPNcxgEgZy0R0Q',
          'Content-Type': file.path.split('.').last == 'jpg'
              ? 'image/jpeg'
              : 'image/${file.path.split('.').last}',
        },
      ),
    );
  }

  Future<void> deleteProblemPhoto(int problemId, int photoId) async {
    await ServerDio.dioInstance.delete(
      '${ApiConstant.baseUrl}problem/$problemId/photos/$photoId',
    );
  }

  Future<void> deleteAllProblemPhotos(int problemId) async {
    await ServerDio.dioInstance.delete(
      '${ApiConstant.baseUrl}problem/$problemId/photos',
    );
  }
}