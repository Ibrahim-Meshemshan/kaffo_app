import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/add_problem_response.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/problem_by_id_model.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problem/problems_content_entity.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/add_problem_use_case.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/address_use_case.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/problem_by_id.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/problems_use_case.dart';

import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/models/result.dart';
import '../../../view_prblem/data/model/presignd_url_response.dart';
import '../../../view_prblem/data/repo/photo_repo.dart';
import '../../data/models/addresses/address_response.dart';
import '../../data/models/user_id/user_response_dto.dart';
import '../../domain/entities/address/address_request.dart';
import '../../domain/entities/problem/add_problem_request.dart';
import '../../domain/use_cases/cities_use_case.dart';
import '../../domain/use_cases/create_address_use_case.dart';
import '../../domain/use_cases/user_use_case.dart';

part 'problems_state.dart';

@injectable
class ProblemsCubit extends Cubit<ProblemsState> {
  final ProblemsUseCase problemsUseCase;
  final UserUseCase userUseCase;
  final AddressUseCase addressUseCase;
  final AddProblemUseCase addProblemUseCase;
  final CreateAddressUseCase createAddressUseCase;
  final CitiesUseCase citiesUseCase;
  final ProblemByIdUseCase problemByIdUseCase;
  final PhotoRepo photoRepo;
  final Dio dio; // أضف Dio

  ProblemsCubit({
    required this.problemsUseCase,
    required this.userUseCase,
    required this.addressUseCase,
    required this.addProblemUseCase,
    required this.createAddressUseCase,
    required this.citiesUseCase,
    required this.problemByIdUseCase,
    required this.photoRepo,
    required this.dio, // أضف Dio
  }) : super(ProblemsState());

  // جلب جميع المشاكل
  Future<void> fetchProblems() async {
    emit(state.copyWith(problemState: Status.loading));
    ApiResult<List<ProblemsContentEntity>> result = await problemsUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<ProblemsContentEntity>>():
        emit(
          state.copyWith(
            problemState: Status.success,
            problemList: result.data,
          ),
        );
      case ApiErrorResult<List<ProblemsContentEntity>>():
        emit(
          state.copyWith(
            problemState: Status.error,
            problemError: result.failures.errorMessage,
          ),
        );
    }
  }

  // جلب بيانات المستخدم
  Future<void> fetchUser(int userId) async {
    if (state.usersMap[userId] == null) {
      ApiResult<UserResponseDto> result = await userUseCase(userId);
      switch (result) {
        case ApiSuccessResult<UserResponseDto>():
          emit(state.copyWith(
            usersMap: {...state.usersMap, userId: result.data!},
            userState: Status.success,
          ));
        case ApiErrorResult<UserResponseDto>():
          print("User fetch error for ID $userId: ${result.failures.errorMessage}");
          emit(state.copyWith(
            userState: Status.error,
            userError: result.failures.errorMessage,
          ));
      }
    }
  }

  // جلب عنوان معين
  Future<void> fetchAddress(int addressId) async {
    if (state.addressMap[addressId] == null) {
      ApiResult<AddressResponse> result = await addressUseCase(addressId);
      switch (result) {
        case ApiSuccessResult<AddressResponse>():
          emit(state.copyWith(
            addressMap: {...state.addressMap, addressId: result.data!},
            addressState: Status.success,
          ));
        case ApiErrorResult<AddressResponse>():
          print("Address fetch error for ID $addressId: ${result.failures.errorMessage}");
          emit(state.copyWith(
            addressState: Status.error,
            addressError: result.failures.errorMessage,
          ));
      }
    }
  }

  // بحث عن مشكلة
  Future<void> fetchProblemById(int problemId) async {
    emit(state.copyWith(problemByIdState: Status.loading));
    ApiResult<ProblemByIdModel> result = await problemByIdUseCase.call(problemId);
    switch (result) {
      case ApiSuccessResult<ProblemByIdModel>():
        emit(state.copyWith(
          problemByIdState: Status.success,
          problemByIdList: result.data,
        ));
      case ApiErrorResult<ProblemByIdModel>():
        emit(state.copyWith(
          problemByIdState: Status.error,
          problemByIdError: result.failures.errorMessage,
        ));
    }
  }

  // إضافة مشكلة جديدة
  Future<ApiResult<AddProblemResponse>> addProblem(AddProblemRequest parameter) async {
    emit(state.copyWith(addProblemState: Status.loading));

    try {
      final result = await addProblemUseCase.call(parameter);

      if (result is ApiSuccessResult<AddProblemResponse>) {
        emit(state.copyWith(
          addProblemState: Status.success,
          addProblemResponse: result.data,
        ));
        return result;
      } else {
        emit(state.copyWith(
          addProblemState: Status.error,
          addProblemError: "Add problem error",
        ));
        return result;
      }
    } catch (e) {
      emit(state.copyWith(
        addProblemState: Status.error,
        addProblemError: e.toString(),
      ));
      return ApiErrorResult(ServerError(errorMessage: e.toString()));
    }
  }

  // جلب قائمة المدن
  Future<void> fetchCities() async {
    emit(state.copyWith(citiesState: Status.loading));
    ApiResult<List<CitiesModel>> result = await citiesUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<CitiesModel>>():
        emit(state.copyWith(
          citiesState: Status.success,
          citiesList: result.data,
        ));
      case ApiErrorResult<List<CitiesModel>>():
        emit(state.copyWith(
          citiesState: Status.error,
          citiesError: result.failures.errorMessage,
        ));
    }
  }

  // الحصول على روابط التوقيع المسبق للصور
  Future<List<PresignedUrlResponse>> getPresignedUrls(
      int problemId,
      int count,
      String contentType, {
        int? progressId,
      }) async {
    try {
      emit(state.copyWith(photoUploadState: Status.loading));

      final result = await photoRepo.getPresignedUrls(
        problemId,
        count,
        contentType: contentType,
        progressId: progressId,
      );

      if (result is ApiSuccessResult<List<PresignedUrlResponse>>) {
        emit(state.copyWith(photoUploadState: Status.success));
        return result.data!;
      } else {
        emit(state.copyWith(
          photoUploadState: Status.error,
          photoUploadError: 'فشل في جلب روابط التحميل',
        ));
        throw Exception('فشل في جلب روابط التحميل');
      }
    } catch (e) {
      emit(state.copyWith(
        photoUploadState: Status.error,
        photoUploadError: e.toString(),
      ));
      throw e;
    }
  }

  // رفع ملف إلى S3 باستخدام Dio
  Future<void> uploadFileToS3(String presignedUrl, File file) async {
    try {
      final fileBytes = await file.readAsBytes();

      final response = await dio.put(
        presignedUrl,
        data: fileBytes,
        options: Options(
          headers: {
            'Content-Type': 'image/${file.path.split('.').last}',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('فشل رفع الملف: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('فشل رفع الملف: ${e.message}');
    } catch (e) {
      throw Exception('فشل رفع الملف: $e');
    }
  }

  // تحديث المشكلة بالصور
  Future<void> updateProblem({
    required int id,
    required AddProblemRequest data,
  }) async {
    try {
      emit(state.copyWith(updateProblemState: Status.loading));

      final result = await addProblemUseCase.call(data);

      if (result is ApiSuccessResult<AddProblemResponse>) {
        emit(state.copyWith(
          updateProblemState: Status.success,
        ));
      } else {
        emit(state.copyWith(
          updateProblemState: Status.error,
          updateProblemError: 'فشل في تحديث المشكلة',
        ));
        throw Exception('فشل في تحديث المشكلة');
      }
    } catch (e) {
      emit(state.copyWith(
        updateProblemState: Status.error,
        updateProblemError: e.toString(),
      ));
      throw e;
    }
  }

  // إنشاء عنوان
  Future<ApiResult<AddressResponse>> createAddress(AddressRequest request) async {
    try {
      final result = await createAddressUseCase.call(request);
      return result;
    } catch (e) {
      return ApiErrorResult(ServerError(errorMessage: e.toString()));
    }
  }

  // دالة مساعدة لإنشاء مشكلة كاملة (عنوان + مشكلة + صور)
  Future<void> createCompleteProblem({
    required String title,
    required String description,
    required int categoryId,
    required String governorate,
    required String address,
    required double lat,
    required double lng,
    required List<File> images,
  }) async {
    try {
      // 1. إنشاء العنوان أولًا
      final addressRequest = AddressRequest(
        city: governorate,
        description: address,
        latitude: lat,
        longitude: lng,
      );

      final addressResult = await createAddress(addressRequest);

      if (addressResult is! ApiSuccessResult<AddressResponse>) {
        throw Exception('فشل في إنشاء العنوان');
      }

      // 2. إنشاء المشكلة بدون صور
      final problemRequest = AddProblemRequest(
        title: title,
        description: description,
        categoryId: categoryId,
        addressId: addressResult.data!.id,
        photoUrls: [],
      );

      final problemResult = await addProblem(problemRequest);

      if (problemResult is! ApiSuccessResult<AddProblemResponse>) {
        throw Exception('فشل في إنشاء المشكلة');
      }

      // 3. رفع الصور إن وجدت
      if (images.isNotEmpty) {
        final presignedData = await getPresignedUrls(
          problemResult.data!.id!.toInt(),
          images.length,
          'image/${images[0].path.split('.').last}',
        );

        await Future.wait(
          images.asMap().entries.map((entry) {
            final index = entry.key;
            final file = entry.value;
            return uploadFileToS3(presignedData[index].presignedUrl, file);
          }),
        );

        final photoUrls = presignedData.map((item) => item.s3Key).toList();

        // تحديث المشكلة بالصور
        await updateProblem(
          id:  problemResult.data!.id!.toInt(),
          data: AddProblemRequest(
            title: title,
            description: description,
            categoryId: categoryId,
            addressId: addressResult.data!.id,
            photoUrls: photoUrls,
          ),
        );
      }

      // نجاح العملية
      emit(state.copyWith(createProblemState: Status.success));

    } catch (e) {
      emit(state.copyWith(
        createProblemState: Status.error,
        createProblemStateError: e.toString(),
      ));
      rethrow;
    }
  }
}