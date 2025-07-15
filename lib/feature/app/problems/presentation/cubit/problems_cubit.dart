// import 'package:bloc/bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:kaffo/core/utils/status.dart';
// import 'package:kaffo/feature/app/problems/data/models/problems/add_problem_response.dart';
// import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
// import 'package:kaffo/feature/app/problems/domain/use_cases/add_problem_use_case.dart';
// import 'package:kaffo/feature/app/problems/domain/use_cases/address_use_case.dart';
// import 'package:kaffo/feature/app/problems/domain/use_cases/problems_use_case.dart';
//
// import '../../../../../core/models/result.dart';
// import '../../data/models/addresses/address_id_dto.dart';
// import '../../data/models/user_id/user_response_dto.dart';
// import '../../domain/entities/add_problem_request_entity.dart';
// import '../../domain/entities/address/address_request.dart';
// import '../../domain/use_cases/create_address_use_case.dart';
// import '../../domain/use_cases/user_use_case.dart';
//
// part 'problems_state.dart';
//
// @injectable
// class ProblemsCubit extends Cubit<ProblemsState> {
//   final ProblemsUseCase problemsUseCase;
//   final UserUseCase userUseCase;
// final AddressUseCase addressUseCase;
//   final AddProblemUseCase addProblemUseCase;
//   final CreateAddressUseCase createAddressUseCase;
//   ProblemsCubit({
//     required this.problemsUseCase,
//     required this.userUseCase,
//     required this.addressUseCase,
//     required this.addProblemUseCase,
//     required this.createAddressUseCase
//   }) : super(ProblemsState());
//
//   Future<void> fetchProblems() async {
//     emit(state.copyWith(problemState: Status.loading));
//     Result<List<ProblemsContentEntity>> result = await problemsUseCase.call();
//     switch (result) {
//       case Success<List<ProblemsContentEntity>>():
//         emit(
//           state.copyWith(
//             problemState: Status.success,
//             problemList: result.data,
//           ),
//         );
//       case Error<List<ProblemsContentEntity>>():
//         emit(
//           state.copyWith(
//             problemState: Status.error,
//             problemError: result.exception.toString(),
//           ),
//         );
//     }
//   }
//   Future<void> fetchUser(int userId) async {
//     if (state.usersMap[userId] == null) {
//       Result<UserResponseDto> result = await userUseCase(userId);
//       switch (result) {
//         case Success<UserResponseDto>():
//           emit(state.copyWith(
//             usersMap: {...state.usersMap, userId: result.data!},
//             userState: Status.success,
//           ));
//         case Error<UserResponseDto>():
//           print("User fetch error for ID $userId: ${result.exception}");
//           emit(state.copyWith(
//             userState: Status.error,
//             userError: result.exception.toString(),
//           ));
//       }
//     }
//   }
//   Future<void> fetchAddress(int addressId) async {
//     if (state.addressMap[addressId] == null) {
//       Result<AddressIdDto> result = await addressUseCase(addressId);
//       switch (result) {
//         case Success<AddressIdDto>():
//           emit(state.copyWith(
//             addressMap: {...state.addressMap, addressId: result.data!},
//             addressState: Status.success,
//           ));
//         case Error<AddressIdDto>():
//           print("Address fetch error for ID $addressId: ${result.exception}");
//           emit(state.copyWith(
//             addressState: Status.error,
//             addressError: result.exception.toString(),
//           ));
//       }
//     }
//   }
//
//
//   Future<void> addProblem(AddProblemRequest parameter) async {
//     emit(state.copyWith(addProblemState: Status.loading));
//     final request = AddProblemRequest(
//       title: parameter.title,
//       description: parameter.description,
//       addressId: parameter.addressId,
//       categoryId: parameter.categoryId,
//     );
//     Result<AddProblemResponse> result = await addProblemUseCase.call(request);
//     switch (result) {
//       case Success<AddProblemResponse>():
//         emit(state.copyWith(
//             addProblemState: Status.success, addProblemResponse: result.data));
//
//       case Error<AddProblemResponse>():
//         emit(state.copyWith(
//             addProblemState: Status.error,
//             addProblemError: result.exception.toString()));
//     }
//   }
//
//
//   Future<void> createProblemWithAddress({
//     required String title,
//     required String description,
//     required double latitude,
//     required double longitude,
//     required String city,
//     required String addressDescription, // وصف العنوان
//     required int categoryId,
//   }) async {
//     emit(state.copyWith(createProblemState: Status.loading));
//
//     try {
//       final AddressRequest addressRequest = AddressRequest(
//         latitude: latitude,
//         longitude: longitude,
//         city: city,
//         description: addressDescription,
//       );
//       final Result<AddressIdDto> addressResponse = await createAddressUseCase(
//           addressRequest);
//
//       final AddProblemRequest problemRequest = AddProblemRequest(
//         title: title,
//         description: description,
//         addressId: addressId,
//         categoryId: categoryId.toString(),
//       );
//
//       final ProblemsContentEntity problemResponse = await addProblemUseCase.call(problemRequest);
//
//       emit(state.copyWith(createProblemState: Status.success,
//           createProblemStateList: problemResponse));
//     } catch (e) {
//       emit(state.copyWith(createProblemState: Status.error,
//           createProblemStateError: e.toString()));
//     }
//   }
//
// }
//
//
//
//
//
//
//
//
//
//
//
//
//   //
//   //
//   // Future<void> addProblem(AddProblemRequest request) async {
//   //   emit(state.copyWith(addProblemState: Status.loading));
//   //
//   //   Result<AddProblemResponseEntity> result = await addProblemUseCase.call(
//   //       request);
//   //
//   //   switch (result) {
//   //     case Success<AddProblemResponseEntity>():
//   //       emit(state.copyWith(
//   //           addProblemState: Status.success, addProblem: result.data));
//   //     case Error<AddProblemResponseEntity>():
//   //       emit(state.copyWith(problemState: Status.error,
//   //           addProblemError: result.exception.toString()));
//   //   }
//   // }
//
//
//
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/problems/data/models/problems/add_problem_response.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problem/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/add_problem_use_case.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/address_use_case.dart';
import 'package:kaffo/feature/app/problems/domain/use_cases/problems_use_case.dart';

import '../../../../../core/models/result.dart';
import '../../data/models/addresses/address_response.dart';
import '../../data/models/user_id/user_response_dto.dart';
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

  ProblemsCubit({
    required this.problemsUseCase,
    required this.userUseCase,
    required this.addressUseCase,
    required this.addProblemUseCase,
    required this.createAddressUseCase,
    required this.citiesUseCase
  }) : super(ProblemsState());

  Future<void> fetchProblems() async {
    emit(state.copyWith(problemState: Status.loading));
    Result<List<ProblemsContentEntity>> result = await problemsUseCase.call();
    switch (result) {
      case Success<List<ProblemsContentEntity>>():
        emit(
          state.copyWith(
            problemState: Status.success,
            problemList: result.data,
          ),
        );
      case Error<List<ProblemsContentEntity>>():
        emit(
          state.copyWith(
            problemState: Status.error,
            problemError: result.exception.toString(),
          ),
        );
    }
  }

  Future<void> fetchUser(int userId) async {
    if (state.usersMap[userId] == null) {
      Result<UserResponseDto> result = await userUseCase(userId);
      switch (result) {
        case Success<UserResponseDto>():
          emit(state.copyWith(
            usersMap: {...state.usersMap, userId: result.data!},
            userState: Status.success,
          ));
        case Error<UserResponseDto>():
          print("User fetch error for ID $userId: ${result.exception}");
          emit(state.copyWith(
            userState: Status.error,
            userError: result.exception.toString(),
          ));
      }
    }
  }

  Future<void> fetchAddress(int addressId) async {
    if (state.addressMap[addressId] == null) {
      Result<AddressResponse> result = await addressUseCase(addressId);
      switch (result) {
        case Success<AddressResponse>():
          emit(state.copyWith(
            addressMap: {...state.addressMap, addressId: result.data!},
            addressState: Status.success,
          ));
        case Error<AddressResponse>():
          print("Address fetch error for ID $addressId: ${result.exception}");
          emit(state.copyWith(
            addressState: Status.error,
            addressError: result.exception.toString(),
          ));
      }
    }
  }


  Future<void> addProblem(AddProblemRequest parameter, AddressResponse addressResponse) async {
    emit(state.copyWith(addProblemState: Status.loading));


    final request = AddProblemRequest(
      title: parameter.title,
      description: parameter.description,
      addressId: addressResponse.id,
      categoryId: parameter.categoryId,
    );
    Result<AddProblemResponse> result = await addProblemUseCase.call(request);
    switch (result) {
      case Success<AddProblemResponse>():
        emit(state.copyWith(
            addProblemState: Status.success, addProblemResponse: result.data));

      case Error<AddProblemResponse>():
        emit(state.copyWith(
            addProblemState: Status.error,
            addProblemError: result.exception.toString()));
    }
  }


  Future<void> fetchCities() async {
    emit(state.copyWith(citiesState: Status.loading));
    Result<List<CitiesModel>> result = await citiesUseCase.call();
    switch (result) {
      case Success<List<CitiesModel>>():
        emit(state.copyWith(
            citiesState: Status.success, citiesList: result.data));
      case Error<List<CitiesModel>>():
        emit(state.copyWith(citiesState: Status.error,
            citiesError: result.exception.toString()));
    }
  }


// Future<void> createProblemWithAddress({
//   required String title,
//   required String description,
//   required double latitude,
//   required double longitude,
//   required String city,
//   required String addressDescription,
//   required int categoryId,
// }) async {
//   emit(state.copyWith(createProblemState: Status.loading));
//
//   try {
//     final AddressRequest addressRequest = AddressRequest(
//       latitude: latitude,
//       longitude: longitude,
//       city: city,
//       description: addressDescription,
//     );
//     final Result<AddressIdDto> addressResponseResult = await createAddressUseCase(addressRequest);
//
//     late int ? createdAddressId;
//     // التحقق من نجاح إنشاء العنوان
//     switch (addressResponseResult) {
//       case Success<AddressIdDto>():
//         createdAddressId = addressResponseResult.data!.id as int?; // <--- استخراج addressId
//         break; // الخروج من الـ switch
//       case Error<AddressIdDto>():
//         emit(state.copyWith(
//             createProblemState: Status.error,
//             createProblemStateError: 'Failed to create address: ${addressResponseResult.exception.toString()}'));
//         return; // الخروج من الدالة لأن إنشاء العنوان فشل
//     }
//
//     // الخطوة 2: إنشاء المشكلة باستخدام createdAddressId
//     final AddProblemRequest problemRequest = AddProblemRequest(
//       title: title,
//       description: description,
//       addressId: addressId,
//       categoryId: categoryId, // تأكد أن categoryId هو String في AddProblemRequest
//     );
//
//     final Result<AddProblemResponse> problemResponseResult = await addProblemUseCase.call(problemRequest); // <--- تصحيح النوع هنا
  //
//     // التحقق من نجاح إنشاء المشكلة
//     switch (problemResponseResult) {
//       case Success<AddProblemResponse>():
//       // بما أن createProblemStateList هو ProblemsContentEntity
//       // يجب تحويل AddProblemResponse إلى ProblemsContentEntity
//       // أو تغيير نوع createProblemStateList ليقبل AddProblemResponse
//       // سأفترض أن AddProblemResponse لديها القدرة على التحويل إلى ProblemsContentEntity
//       // أو أنك ستقوم بتعديل `createProblemStateList` في `ProblemsState` ليقبل `AddProblemResponse`
  //
//       // إذا كانت AddProblemResponse و ProblemsContentEntity متطابقتين (أو AddProblemResponse يمكن تحويلها إلى ProblemsContentEntity)
//       // يجب أن يكون لديك دالة toEntity() في AddProblemResponse أو map يدوي
//         final ProblemsContentEntity finalProblemEntity = ProblemsContentEntity( // مثال للتحويل
//           id: problemResponseResult.data!.id,
//           title: problemResponseResult.data?.title,
//           description: problemResponseResult.data?.description,
//           addressId: problemResponseResult.data!.addressId,
//           categoryId: problemResponseResult.data!.categoryId
//           // ... قم بملء بقية الخصائص من problemResponseResult.data
//           // هذا يعتمد على مطابقة الحقول بين AddProblemResponse و ProblemsContentEntity
//         );
  //
//
//         emit(state.copyWith(
//             createProblemState: Status.success,
//             createProblemStateList: finalProblemEntity));
//         break;
//       case Error<AddProblemResponse>():
//         emit(state.copyWith(
//             createProblemState: Status.error,
//             createProblemStateError: 'Failed to add problem: ${problemResponseResult.exception.toString()}'));
//         break;
//     }
//   } catch (e) {
//     emit(state.copyWith(
//         createProblemState: Status.error,
//         createProblemStateError: e.toString()));
//   }
// }
}


// @injectable
// class ProblemsCubit extends Cubit<ProblemsState> {
//   final ProblemsUseCase problemsUseCase;
//   final UserUseCase userUseCase;
//   final AddressUseCase addressUseCase;
//   final AddProblemUseCase addProblemUseCase;
//   final CreateAddressUseCase createAddressUseCase;
//   final CitiesUseCase citiesUseCase;
//
//   ProblemsCubit({
//     required this.problemsUseCase,
//     required this.userUseCase,
//     required this.addressUseCase,
//     required this.addProblemUseCase,
//     required this.createAddressUseCase,
//     required this.citiesUseCase,
//   }) : super(ProblemsState());
//
//   // جلب جميع المشاكل
//   Future<void> fetchProblems() async {
//     emit(state.copyWith(problemState: Status.loading));
//     Result<List<ProblemsContentEntity>> result = await problemsUseCase.call();
//     switch (result) {
//       case Success<List<ProblemsContentEntity>>():
//         emit(
//           state.copyWith(
//             problemState: Status.success,
//             problemList: result.data,
//           ),
//         );
//       case Error<List<ProblemsContentEntity>>():
//         emit(
//           state.copyWith(
//             problemState: Status.error,
//             problemError: result.exception.toString(),
//           ),
//         );
//     }
//   }
//
//   // جلب بيانات المستخدم
//   Future<void> fetchUser(int userId) async {
//     if (state.usersMap[userId] == null) {
//       Result<UserResponseDto> result = await userUseCase(userId);
//       switch (result) {
//         case Success<UserResponseDto>():
//           emit(state.copyWith(
//             usersMap: {...state.usersMap, userId: result.data!},
//             userState: Status.success,
//           ));
//         case Error<UserResponseDto>():
//           print("User fetch error for ID $userId: ${result.exception}");
//           emit(state.copyWith(
//             userState: Status.error,
//             userError: result.exception.toString(),
//           ));
//       }
//     }
//   }
//
//   // جلب عنوان معين
//   Future<void> fetchAddress(int addressId) async {
//     if (state.addressMap[addressId] == null) {
//       Result<AddressResponse> result = await addressUseCase(addressId);
//       switch (result) {
//         case Success<AddressResponse>():
//           emit(state.copyWith(
//             addressMap: {...state.addressMap, addressId: result.data!},
//             addressState: Status.success,
//           ));
//         case Error<AddressResponse>():
//           print("Address fetch error for ID $addressId: ${result.exception}");
//           emit(state.copyWith(
//             addressState: Status.error,
//             addressError: result.exception.toString(),
//           ));
//       }
//     }
//   }
//
//   // إضافة مشكلة جديدة
//   Future<void> addProblem(AddProblemRequest parameter, AddressResponse addressResponse) async {
//     emit(state.copyWith(addProblemState: Status.loading));
//
//     // إعداد البيانات المطلوبة لإرسالها في الطلب
//     final request = AddProblemRequest(
//       title: parameter.title,
//       description: parameter.description,
//       addressId: addressResponse.id,
//       categoryId: parameter.categoryId,
//     );
//
//     // إرسال الطلب لإضافة المشكلة
//     Result<AddProblemResponse> result = await addProblemUseCase.call(request);
//     switch (result) {
//       case Success<AddProblemResponse>():
//       // إضافة المشكلة الجديدة إلى القائمة في الحالة
//         emit(state.copyWith(
//           addProblemState: Status.success,
//           addProblemResponse: result.data,
//           // إضافة المشكلة الجديدة إلى قائمة المشاكل الحالية
//           problemList: [
//             ...?state.problemList, // الاحتفاظ بالمشاكل السابقة
//             ProblemsContentEntity.fromJson(result.data!.toJson()) // إضافة المشكلة الجديدة
//           ],
//         ));
//         break;
//
//       case Error<AddProblemResponse>():
//         emit(state.copyWith(
//           addProblemState: Status.error,
//           addProblemError: result.exception.toString(),
//         ));
//         break;
//     }
//   }
//
//   // جلب قائمة المدن
//   Future<void> fetchCities() async {
//     emit(state.copyWith(citiesState: Status.loading));
//     Result<List<CitiesModel>> result = await citiesUseCase.call();
//     switch (result) {
//       case Success<List<CitiesModel>>():
//         emit(state.copyWith(
//             citiesState: Status.success, citiesList: result.data));
//       case Error<List<CitiesModel>>():
//         emit(state.copyWith(citiesState: Status.error,
//             citiesError: result.exception.toString()));
//     }
//   }
// }
