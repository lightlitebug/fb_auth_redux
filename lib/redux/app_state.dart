import 'package:equatable/equatable.dart';

import 'change_password/change_password_state.dart';
import 'profile/profile_state.dart';
import 'reset_password/reset_password_state.dart';
import 'signin/signin_state.dart';
import 'signup/signup_state.dart';

class AppState extends Equatable {
  final SignupState signupState;
  final SigninState signinState;
  final ResetPasswordState resetPasswordState;
  final ProfileState profileState;
  final ChangePasswordState changePasswordState;
  const AppState({
    required this.signupState,
    required this.signinState,
    required this.resetPasswordState,
    required this.profileState,
    required this.changePasswordState,
  });

  factory AppState.initial() {
    return AppState(
      signupState: SignupState.initial(),
      signinState: SigninState.initial(),
      resetPasswordState: ResetPasswordState.initial(),
      profileState: ProfileState.initial(),
      changePasswordState: ChangePasswordState.initial(),
    );
  }

  @override
  List<Object> get props {
    return [
      signupState,
      signinState,
      resetPasswordState,
      profileState,
      changePasswordState,
    ];
  }

  @override
  String toString() {
    return 'AppState(signupState: $signupState, signinState: $signinState, resetPasswordState: $resetPasswordState, profileState: $profileState, changePasswordState: $changePasswordState)';
  }

  AppState copyWith({
    SignupState? signupState,
    SigninState? signinState,
    ResetPasswordState? resetPasswordState,
    ProfileState? profileState,
    ChangePasswordState? changePasswordState,
  }) {
    return AppState(
      signupState: signupState ?? this.signupState,
      signinState: signinState ?? this.signinState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      profileState: profileState ?? this.profileState,
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }
}
