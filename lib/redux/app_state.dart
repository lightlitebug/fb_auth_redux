import 'package:equatable/equatable.dart';

import 'signup/signup_state.dart';

class AppState extends Equatable {
  final SignupState signupState;

  const AppState({
    required this.signupState,
  });

  factory AppState.initial() {
    return AppState(
      signupState: SignupState.initial(),
    );
  }

  @override
  List<Object> get props {
    return [signupState];
  }

  @override
  String toString() {
    return 'AppState(signupState: $signupState)';
  }

  AppState copyWith({
    SignupState? signupState,
  }) {
    return AppState(
      signupState: signupState ?? this.signupState,
    );
  }
}
