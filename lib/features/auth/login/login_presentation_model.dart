import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : userName = '',
        password = '',
        loginResult = const FutureResult.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.loginResult,
    required this.password,
    required this.userName,
  });

  final FutureResult<Either<LogInFailure, User>> loginResult;
  final String userName;
  final String password;
  @override
  bool get isLoginEnabled => userName.isNotEmpty && password.isNotEmpty;

  @override
  bool get isLoading => loginResult.isPending();

  LoginPresentationModel copyWith({
    String? userName,
    String? password,
    FutureResult<Either<LogInFailure, User>>? loginResult,
  }) {
    return LoginPresentationModel._(
      loginResult: loginResult ?? this.loginResult,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoading;
  bool get isLoginEnabled;
}
