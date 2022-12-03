import 'app_state.dart';
import 'change_password/change_password_reducer.dart';
import 'profile/profile_reducer.dart';
import 'reset_password/reset_password_reducer.dart';
import 'signin/signin_reducer.dart';
import 'signup/signup_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    signupState: signupReducer(state.signupState, action),
    signinState: signinReducer(state.signinState, action),
    resetPasswordState: resetPasswordReducer(state.resetPasswordState, action),
    profileState: profileReducer(state.profileState, action),
    changePasswordState:
        changePasswordReducer(state.changePasswordState, action),
  );
}
