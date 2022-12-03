import 'package:redux/redux.dart';

import 'reset_password_action.dart';
import 'reset_password_state.dart';

ResetPasswordState resetPasswordRequestReducer(
  ResetPasswordState state,
  ResetPasswordRequestAction action,
) {
  return state.copyWith(resetPasswordStatus: ResetPasswordStatus.submitting);
}

ResetPasswordState resetPasswordSucceededReducer(
  ResetPasswordState state,
  ResetPasswordSucceededAction action,
) {
  return state.copyWith(resetPasswordStatus: ResetPasswordStatus.success);
}

ResetPasswordState resetPasswordFailedReducer(
  ResetPasswordState state,
  ResetPasswordFailedAction action,
) {
  return state.copyWith(
    resetPasswordStatus: ResetPasswordStatus.failure,
    error: action.error,
  );
}

Reducer<ResetPasswordState> resetPasswordReducer =
    combineReducers<ResetPasswordState>([
  TypedReducer<ResetPasswordState, ResetPasswordRequestAction>(
    resetPasswordRequestReducer,
  ),
  TypedReducer<ResetPasswordState, ResetPasswordSucceededAction>(
    resetPasswordSucceededReducer,
  ),
  TypedReducer<ResetPasswordState, ResetPasswordFailedAction>(
    resetPasswordFailedReducer,
  ),
]);
