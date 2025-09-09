import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:kaffo/core/models/result.dart';
import 'package:kaffo/core/utils/secure_storage.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/feature/auth/login/data/model/login_request/login_request.dart';
import 'package:kaffo/feature/auth/login/data/model/login_response/login_response.dart';

import 'package:kaffo/feature/auth/login/domain/usecases/login_usecase.dart';

part 'login_state.dart';
@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();



  LoginCubit(this.loginUsecase)
      : super(LoginState());

  Future<void> login(LoginRequest loginRequest) async {
    emit(state.copyWith(loginState: Status.loading));
    Result<LoginResponse> result = await loginUsecase.invoke(loginRequest: loginRequest);
    switch (result) {
      case Success<LoginResponse>():
        await writeSecureData("access_token", result.data!.access_token!);

        emit(
          state.copyWith(
            loginState: Status.success,
            loginResponse: result.data,
          ),
        );
      case Error<LoginResponse>():
        emit(
          state.copyWith(
            loginState: Status.error,
            loginError: result.exception.toString(),
          ),
        );
    }
  }


}
