import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';
import '../app_state.dart';

class SigninRequestAction {
  @override
  String toString() {
    return 'SigninRequestAction()';
  }
}

class SigninSucceededAction {
  @override
  String toString() {
    return 'SigninSucceededAction()';
  }
}

class SigninFailedAction {
  final CustomError error;
  SigninFailedAction({
    required this.error,
  });

  @override
  String toString() => 'SigninFailedAction(error: $error)';
}

ThunkAction<AppState> signinAndDispatch(
  String email,
  String password,
) {
  return (Store<AppState> store) async {
    store.dispatch(SigninRequestAction());

    try {
      await AuthRepository.instance.signin(email: email, password: password);

      store.dispatch(SigninSucceededAction());
    } on CustomError catch (e) {
      store.dispatch(SigninFailedAction(error: e));
    }
  };
}
