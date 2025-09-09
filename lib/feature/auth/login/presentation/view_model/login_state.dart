
part of 'login_cubit.dart';

class LoginState extends Equatable {

  final Status loginState;
  final String? loginError;
  final LoginResponse?loginResponse;

  LoginState({this.loginState=Status.initial, this.loginError, this.loginResponse});





  LoginState copyWith({
 Status? loginState,
    String? loginError,
  LoginResponse?loginResponse,
  }) {
    return LoginState(
      loginState: loginState??this.loginState,
      loginError: loginError??this.loginError,
      loginResponse: loginResponse??this.loginResponse,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [        loginResponse,loginState,loginError
      ];

}