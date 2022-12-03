import 'package:equatable/equatable.dart';

import 'signin/signin_state.dart';
import 'signup/signup_state.dart';

class AppState extends Equatable {
  final SignupState signupState;
  final SigninState signinState;

  const AppState({
    required this.signupState,
    required this.signinState,
  });

  factory AppState.initial() {
    return AppState(
      signupState: SignupState.initial(),
      signinState: SigninState.initial(),
    );
  }

  @override
  List<Object> get props => [signupState, signinState];

  @override
  String toString() =>
      'AppState(signupState: $signupState, signinState: $signinState)';

  AppState copyWith({
    SignupState? signupState,
    SigninState? signinState,
  }) {
    return AppState(
      signupState: signupState ?? this.signupState,
      signinState: signinState ?? this.signinState,
    );
  }
}
