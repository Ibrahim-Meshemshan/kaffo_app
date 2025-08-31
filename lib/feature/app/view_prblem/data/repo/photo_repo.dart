// photo_repo.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/models/result.dart';
import '../data_source/photo_data_source.dart';
import '../model/photo_response_model.dart';
import '../model/presignd_url_response.dart';

@injectable
class PhotoRepo {
  final PhotoDataSource _dataSource;

  PhotoRepo(this._dataSource);

  Future<ApiResult<List<PhotoResponseModel>>> getProblemPhotos(int problemId) async {
    try {
      final response = await _dataSource.getProblemPhotos(problemId);
      return ApiSuccessResult(response);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }

  Future<ApiResult<List<PresignedUrlResponse>>> getPresignedUrls(
      int problemId,
      int count, {
        String? contentType,
        int? progressId,
      }) async {
    try {
      final response = await _dataSource.getPresignedUrls(
        problemId,
        count,
        contentType: contentType,
        progressId: progressId,
      );
      return ApiSuccessResult(response);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }

  Future<ApiResult<void>> uploadFileToS3(String presignedUrl, File file) async {
    try {
      await _dataSource.uploadFileToS3(presignedUrl, file);
      return ApiSuccessResult(null);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }

  Future<ApiResult<void>> deleteProblemPhoto(int problemId, int photoId) async {
    try {
      await _dataSource.deleteProblemPhoto(problemId, photoId);
      return ApiSuccessResult(null);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }

  Future<ApiResult<void>> deleteAllProblemPhotos(int problemId) async {
    try {
      await _dataSource.deleteAllProblemPhotos(problemId);
      return ApiSuccessResult(null);
    } on DioException catch (error) {
      return ApiErrorResult(ServerError(errorMessage: error.message ?? ''),
      );
    }
  }
}