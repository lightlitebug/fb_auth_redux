import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'app_state.dart';

List<Middleware<AppState>> appMiddleware() {
  return [thunkMiddleware];
}
