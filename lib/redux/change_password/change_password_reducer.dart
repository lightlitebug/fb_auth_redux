import 'package:redux/redux.dart';

import 'change_password_action.dart';
import 'change_password_state.dart';

ChangePasswordState changePasswordRequestReducer(
  ChangePasswordState state,
  ChangePasswordRequestAction action,
) {
  return state.copyWith(changePasswordStatus: ChangePasswordStatus.submitting);
}

ChangePasswordState changePasswordSucceededReducer(
  ChangePasswordState state,
  ChangePasswordSucceededAction action,
) {
  return state.copyWith(changePasswordStatus: ChangePasswordStatus.success);
}

ChangePasswordState changePasswordFailedReducer(
  ChangePasswordState state,
  ChangePasswordFailedAction action,
) {
  return state.copyWith(
    changePasswordStatus: ChangePasswordStatus.failure,
    error: action.error,
  );
}

Reducer<ChangePasswordState> changePasswordReducer =
    combineReducers<ChangePasswordState>([
  TypedReducer<ChangePasswordState, ChangePasswordRequestAction>(
    changePasswordRequestReducer,
  ),
  TypedReducer<ChangePasswordState, ChangePasswordSucceededAction>(
    changePasswordSucceededReducer,
  ),
  TypedReducer<ChangePasswordState, ChangePasswordFailedAction>(
    changePasswordFailedReducer,
  ),
]);
