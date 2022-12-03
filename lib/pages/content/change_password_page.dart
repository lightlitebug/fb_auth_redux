import 'package:equatable/equatable.dart';
import 'package:fb_auth_redux/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../models/custom_error.dart';
import '../../redux/change_password/change_password_action.dart';
import '../../redux/change_password/change_password_state.dart';
import '../../repositories/auth_repository.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/form_fields.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    StoreProvider.of<AppState>(context).dispatch(
      changePasswordAndDispatch(
        _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Change Password'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: [
                  const FlutterLogo(size: 150),
                  const SizedBox(height: 20.0),
                  PasswordFormField(
                    passwordController: _passwordController,
                    labelText: 'New password',
                  ),
                  const SizedBox(height: 20.0),
                  ConfirmPasswordFormField(
                    passwordController: _passwordController,
                    labelText: 'Confirm new password',
                  ),
                  const SizedBox(height: 20.0),
                  StoreConnector<AppState, _ViewModel>(
                    distinct: true,
                    onWillChange: (_ViewModel? prev, _ViewModel current) async {
                      if (current.changePasswordStatus ==
                          ChangePasswordStatus.failure) {
                        errorDialog(context, current.error);
                      } else if (prev!.changePasswordStatus ==
                              ChangePasswordStatus.submitting &&
                          current.changePasswordStatus ==
                              ChangePasswordStatus.success) {
                        try {
                          final navigator = Navigator.of(context);
                          await AuthRepository.instance.signout();
                          navigator.popUntil((route) => route.isFirst);
                        } on CustomError catch (e) {
                          errorDialog(context, e);
                        }
                      }
                    },
                    converter: (Store<AppState> store) =>
                        _ViewModel.fromStore(store),
                    builder: (BuildContext context, _ViewModel vm) {
                      final status = vm.changePasswordStatus;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: status == ChangePasswordStatus.submitting
                                ? null
                                : _submit,
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                            ),
                            child: Text(
                              status == ChangePasswordStatus.submitting
                                  ? 'Submitting...'
                                  : 'Change Password',
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('If you change password,'),
                              Text.rich(
                                TextSpan(
                                  text: 'you will be ',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'signed out!',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final ChangePasswordStatus changePasswordStatus;
  final CustomError error;
  const _ViewModel({
    required this.changePasswordStatus,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      changePasswordStatus:
          store.state.changePasswordState.changePasswordStatus,
      error: store.state.changePasswordState.error,
    );
  }

  @override
  List<Object> get props => [changePasswordStatus, error];
}
