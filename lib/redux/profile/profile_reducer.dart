import 'package:redux/redux.dart';

import 'profile_action.dart';
import 'profile_state.dart';

ProfileState getProfileReducer(
  ProfileState state,
  GetProfileAction action,
) {
  return state.copyWith(profileStatus: ProfileStatus.submitting);
}

ProfileState getProfileSucceededReducer(
  ProfileState state,
  GetProfileSucceededAction action,
) {
  return state.copyWith(
    profileStatus: ProfileStatus.success,
    appUser: action.appUser,
  );
}

ProfileState getProfileFailedReducer(
  ProfileState state,
  GetProfileFailedAction action,
) {
  return state.copyWith(
    profileStatus: ProfileStatus.failure,
    error: action.error,
  );
}

Reducer<ProfileState> profileReducer = combineReducers<ProfileState>([
  TypedReducer<ProfileState, GetProfileAction>(
    getProfileReducer,
  ),
  TypedReducer<ProfileState, GetProfileSucceededAction>(
    getProfileSucceededReducer,
  ),
  TypedReducer<ProfileState, GetProfileFailedAction>(
    getProfileFailedReducer,
  ),
]);
