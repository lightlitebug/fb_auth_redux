import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';
import '../app_state.dart';

class SignupRequestAction {
  @override
  String toString() => 'SignupRequestAction()';
}

class SignupSucceededAction {
  @override
  String toString() => 'SignupSucceededAction()';
}

class SignupFailedAction {
  final CustomError error;
  SignupFailedAction({
    required this.error,
  });

  @override
  String toString() => 'SignupFailedAction(error: $error)';
}

ThunkAction<AppState> signupAndDispatch(
  String name,
  String email,
  String password,
) {
  return (Store<AppState> store) async {
    store.dispatch(SignupRequestAction());

    try {
      await AuthRepository.instance.signup(
        name: name,
        email: email,
        password: password,
      );
      store.dispatch(SignupSucceededAction());
    } on CustomError catch (e) {
      store.dispatch(SignupFailedAction(error: e));
    }
  };
}
