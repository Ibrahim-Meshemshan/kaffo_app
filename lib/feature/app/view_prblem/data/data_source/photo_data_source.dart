import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/api_manager/server_dio.dart';

import '../../../../../core/api_manager/api_constant.dart';
import '../../../../../core/api_manager/api_di.dart';
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
          'Authorization': DioInjection.token,
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