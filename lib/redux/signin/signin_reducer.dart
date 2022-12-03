import 'package:redux/redux.dart';

import 'signin_state.dart';
import 'signin_action.dart';

SigninState signinRequestReducer(
  SigninState state,
  SigninRequestAction action,
) {
  return state.copyWith(signinStatus: SigninStatus.submitting);
}

SigninState signinSucceededReducer(
  SigninState state,
  SigninSucceededAction action,
) {
  return state.copyWith(signinStatus: SigninStatus.success);
}

SigninState signinFailedReducer(
  SigninState state,
  SigninFailedAction action,
) {
  return state.copyWith(
    signinStatus: SigninStatus.failure,
    error: action.error,
  );
}

Reducer<SigninState> signinReducer = combineReducers<SigninState>([
  TypedReducer<SigninState, SigninRequestAction>(signinRequestReducer),
  TypedReducer<SigninState, SigninSucceededAction>(signinSucceededReducer),
  TypedReducer<SigninState, SigninFailedAction>(signinFailedReducer),
]);
