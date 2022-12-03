import 'package:redux/redux.dart';

import 'signup_action.dart';
import 'signup_state.dart';

SignupState signupRequestReducer(
  SignupState state,
  SignupRequestAction action,
) {
  return state.copyWith(signupStatus: SignupStatus.submitting);
}

SignupState signupSucceededReducer(
  SignupState state,
  SignupSucceededAction action,
) {
  return state.copyWith(signupStatus: SignupStatus.success);
}

SignupState signupFailedReducer(
  SignupState state,
  SignupFailedAction action,
) {
  return state.copyWith(
    signupStatus: SignupStatus.failure,
    error: action.error,
  );
}

Reducer<SignupState> signupReducer = combineReducers<SignupState>([
  TypedReducer<SignupState, SignupRequestAction>(signupRequestReducer),
  TypedReducer<SignupState, SignupSucceededAction>(signupSucceededReducer),
  TypedReducer<SignupState, SignupFailedAction>(signupFailedReducer),
]);
