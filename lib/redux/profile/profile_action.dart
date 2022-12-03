import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/app_user.dart';
import '../../models/custom_error.dart';
import '../../repositories/profile_repository.dart';
import '../app_state.dart';

class GetProfileAction {
  @override
  String toString() => 'GetProfileAction()';
}

class GetProfileSucceededAction {
  final AppUser appUser;
  GetProfileSucceededAction({
    required this.appUser,
  });

  @override
  String toString() => 'GetProfileSucceededAction(appUser: $appUser)';
}

class GetProfileFailedAction {
  final CustomError error;
  GetProfileFailedAction({
    required this.error,
  });

  @override
  String toString() => 'GetProfileFailedAction(error: $error)';
}

ThunkAction<AppState> getProfileAndDispatch(String uid) {
  return (Store<AppState> store) async {
    store.dispatch(GetProfileAction());

    try {
      final appUser = await ProfileRepository.instance.getProfile(uid: uid);
      store.dispatch(GetProfileSucceededAction(appUser: appUser));
    } on CustomError catch (e) {
      store.dispatch(GetProfileFailedAction(error: e));
    }
  };
}
