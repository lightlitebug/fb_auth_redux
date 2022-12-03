import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';
import 'reset_password_state.dart';

class ResetPasswordRequestAction {
  @override
  String toString() {
    return 'ResetPasswordRequestAction()';
  }
}

class ResetPasswordSucceededAction {
  @override
  String toString() {
    return 'ResetPasswordSucceededAction()';
  }
}

class ResetPasswordFailedAction {
  final CustomError error;
  ResetPasswordFailedAction({
    required this.error,
  });

  @override
  String toString() => 'ResetPasswordFailedAction(error: $error)';
}

ThunkAction<ResetPasswordState> resetPasswordAndDispatch(
  String email,
) {
  return (Store store) async {
    store.dispatch(ResetPasswordRequestAction());

    try {
      await AuthRepository.instance.sendPasswordResetEmail(email);

      store.dispatch(ResetPasswordSucceededAction());
    } on CustomError catch (e) {
      store.dispatch(ResetPasswordFailedAction(error: e));
    }
  };
}
