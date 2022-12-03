import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';
import '../app_state.dart';

class ChangePasswordRequestAction {
  @override
  String toString() => 'ChangePasswordRequestAction()';
}

class ChangePasswordSucceededAction {
  @override
  String toString() => 'ChangePasswordSucceededAction()';
}

class ChangePasswordFailedAction {
  final CustomError error;
  ChangePasswordFailedAction({
    required this.error,
  });

  @override
  String toString() => 'ChangePasswordFailedAction(error: $error)';
}

ThunkAction<AppState> changePasswordAndDispatch(
  String password,
) {
  return (Store<AppState> store) async {
    store.dispatch(ChangePasswordRequestAction());

    try {
      await AuthRepository.instance.changePassword(password);
      store.dispatch(ChangePasswordSucceededAction());
    } on CustomError catch (e) {
      store.dispatch(ChangePasswordFailedAction(error: e));
    }
  };
}
