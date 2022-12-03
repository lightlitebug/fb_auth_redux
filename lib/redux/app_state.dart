import 'package:equatable/equatable.dart';

import 'reset_password/reset_password_state.dart';
import 'signin/signin_state.dart';
import 'signup/signup_state.dart';

class AppState extends Equatable {
  final SignupState signupState;
  final SigninState signinState;
  final ResetPasswordState resetPasswordState;

  const AppState({
    required this.signupState,
    required this.signinState,
    required this.resetPasswordState,
  });

  factory AppState.initial() {
    return AppState(
      signupState: SignupState.initial(),
      signinState: SigninState.initial(),
      resetPasswordState: ResetPasswordState.initial(),
    );
  }

  @override
  List<Object> get props => [signupState, signinState, resetPasswordState];

  @override
  String toString() =>
      'AppState(signupState: $signupState, signinState: $signinState, resetPasswordState: $resetPasswordState)';

  AppState copyWith({
    SignupState? signupState,
    SigninState? signinState,
    ResetPasswordState? resetPasswordState,
  }) {
    return AppState(
      signupState: signupState ?? this.signupState,
      signinState: signinState ?? this.signinState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }
}
