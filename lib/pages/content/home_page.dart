import 'package:equatable/equatable.dart';
import 'package:fb_auth_redux/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../models/app_user.dart';
import '../../models/custom_error.dart';
import '../../redux/app_state.dart';
import '../../redux/profile/profile_action.dart';
import '../../redux/profile/profile_state.dart';
import '../../repositories/auth_repository.dart';
import 'change_password_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await AuthRepository.instance.signout();
              } on CustomError catch (e) {
                errorDialog(context, e);
              }
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: StoreConnector<AppState, _ViewModel>(
          distinct: true,
          onInit: (Store<AppState> store) {
            final String uid = AuthRepository.uid!;
            store.dispatch(getProfileAndDispatch(uid));
          },
          onWillChange: (_ViewModel? prev, _ViewModel current) {
            if (current.profileStatus == ProfileStatus.failure) {
              errorDialog(context, current.error);
            }
          },
          converter: (Store<AppState> store) => _ViewModel.fromStore(store),
          builder: (BuildContext context, _ViewModel vm) {
            if (vm.profileStatus == ProfileStatus.submitting) {
              return const CircularProgressIndicator();
            } else if (vm.profileStatus == ProfileStatus.failure) {
              return const Text(
                'Fail to fetch profile.\nTry later.',
                style: TextStyle(fontSize: 18.0, color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            final appUser = vm.appUser;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome ${appUser.name}',
                  style: const TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Your Profile',
                  style: TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'email: ${appUser.email}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  'id: ${appUser.id}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const ChangePasswordPage();
            }),
          );
        },
        label: const Text('Change Password'),
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final ProfileStatus profileStatus;
  final AppUser appUser;
  final CustomError error;
  const _ViewModel({
    required this.profileStatus,
    required this.appUser,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      profileStatus: store.state.profileState.profileStatus,
      appUser: store.state.profileState.appUser,
      error: store.state.profileState.error,
    );
  }

  @override
  List<Object> get props => [profileStatus, appUser, error];
}
