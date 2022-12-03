import 'package:equatable/equatable.dart';

import 'profile/profile_state.dart';
import 'reset_password/reset_password_state.dart';
import 'signin/signin_state.dart';
import 'signup/signup_state.dart';

class AppState extends Equatable {
  final SignupState signupState;
  final SigninState signinState;
  final ResetPasswordState resetPasswordState;
  final ProfileState profileState;
  const AppState({
    required this.signupState,
    required this.signinState,
    required this.resetPasswordState,
    required this.profileState,
  });

  factory AppState.initial() {
    return AppState(
      signupState: SignupState.initial(),
      signinState: SigninState.initial(),
      resetPasswordState: ResetPasswordState.initial(),
      profileState: ProfileState.initial(),
    );
  }

  @override
  List<Object> get props =>
      [signupState, signinState, resetPasswordState, profileState];

  @override
  String toString() {
    return 'AppState(signupState: $signupState, signinState: $signinState, resetPasswordState: $resetPasswordState, profileState: $profileState)';
  }

  AppState copyWith({
    SignupState? signupState,
    SigninState? signinState,
    ResetPasswordState? resetPasswordState,
    ProfileState? profileState,
  }) {
    return AppState(
      signupState: signupState ?? this.signupState,
      signinState: signinState ?? this.signinState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      profileState: profileState ?? this.profileState,
    );
  }
}
