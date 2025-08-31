import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/app_consts/api_constant.dart';
import '../model/photo_response_model.dart';
import '../model/presignd_url_response.dart';

@singleton
class PhotoDataSource {
  final Dio dio;

  PhotoDataSource(this.dio);

  Future<List<PhotoResponseModel>> getProblemPhotos(int problemId) async {
    final response = await dio.get(
      '${ApiConstant.baseUrl}/api/v1/problem/$problemId/photos',
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
    final url = '${ApiConstant.baseUrl}/api/v1/problem/$problemId/photos';

    final queryParameters = {
      'count': count.toString(),
      if (contentType != null) 'contentType': contentType,
      if (progressId != null) 'progressId': progressId.toString(),
    };

    final response = await dio.post(
      url,
      queryParameters: queryParameters,
    );

    return (response.data as List)
        .map((item) => PresignedUrlResponse.fromJson(item))
        .toList();
  }

  Future<void> uploadFileToS3(String presignedUrl, File file) async {
    final bytes = await file.readAsBytes();

    await dio.put(
      presignedUrl,
      data: bytes,
      options: Options(
        headers: {
          'Content-Type': file.path.split('.').last == 'jpg'
              ? 'image/jpeg'
              : 'image/${file.path.split('.').last}',
        },
      ),
    );
  }

  Future<void> deleteProblemPhoto(int problemId, int photoId) async {
    await dio.delete(
      '${ApiConstant.baseUrl}/api/v1/problem/$problemId/photos/$photoId',
    );
  }

  Future<void> deleteAllProblemPhotos(int problemId) async {
    await dio.delete(
      '${ApiConstant.baseUrl}/api/v1/problem/$problemId/photos',
    );
  }
}