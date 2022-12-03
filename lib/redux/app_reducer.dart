import 'app_state.dart';
import 'signup/signup_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    signupState: signupReducer(state.signupState, action),
  );
}
