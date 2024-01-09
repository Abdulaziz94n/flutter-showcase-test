import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.loginUseCase,
    this.navigator,
  );

  final LoginNavigator navigator;
  final LogInUseCase loginUseCase;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void onUserNameChange(String value) => emit(
        _model.copyWith(userName: value),
      );

  void onPasswordChange(String value) => emit(
        _model.copyWith(password: value),
      );

  Future<void> login() async {
    await await loginUseCase
        .execute(username: _model.userName, password: _model.password)
        .observeStatusChanges((res) => emit(_model.copyWith(loginResult: res)))
        .asyncFold(
          (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
          (success) => navigator.showAlert(
            title: 'Welcome',
            message: 'Welcome Message',
          ),
        );
  }
}
