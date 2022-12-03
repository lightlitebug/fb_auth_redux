import 'app_state.dart';
import 'signin/signin_reducer.dart';
import 'signup/signup_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    signupState: signupReducer(state.signupState, action),
    signinState: signinReducer(state.signinState, action),
  );
}
