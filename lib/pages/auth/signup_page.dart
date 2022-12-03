import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../models/custom_error.dart';
import '../../redux/app_state.dart';
import '../../redux/signup/signup_action.dart';
import '../../redux/signup/signup_state.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/form_fields.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    StoreProvider.of<AppState>(context).dispatch(
      signupAndDispatch(
        _nameController.text.trim(),
        _emailController.text.trim(),
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
                  NameFormField(nameController: _nameController),
                  const SizedBox(height: 20.0),
                  EmailFormField(emailController: _emailController),
                  const SizedBox(height: 20.0),
                  PasswordFormField(
                    passwordController: _passwordController,
                    labelText: 'Password',
                  ),
                  const SizedBox(height: 20.0),
                  ConfirmPasswordFormField(
                    passwordController: _passwordController,
                    labelText: 'Confirm password',
                  ),
                  const SizedBox(height: 20.0),
                  StoreConnector<AppState, _ViewModel>(
                    distinct: true,
                    converter: (Store<AppState> store) =>
                        _ViewModel.fromStore(store),
                    onWillChange: (_ViewModel? prev, _ViewModel current) {
                      if (current.signupStatus == SignupStatus.failure) {
                        errorDialog(context, current.error);
                      } else if (prev!.signupStatus ==
                              SignupStatus.submitting &&
                          current.signupStatus == SignupStatus.success) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    },
                    builder: (BuildContext context, _ViewModel vm) {
                      final status = vm.signupStatus;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: status == SignupStatus.submitting
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
                              status == SignupStatus.submitting
                                  ? 'Submitting...'
                                  : 'Sign Up',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already a member? '),
                              TextButton(
                                onPressed: status == SignupStatus.submitting
                                    ? null
                                    : () => Navigator.of(context).pop(),
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('Sign In!'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  )
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
  final SignupStatus signupStatus;
  final CustomError error;
  const _ViewModel({
    required this.signupStatus,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      signupStatus: store.state.signupState.signupStatus,
      error: store.state.signupState.error,
    );
  }

  @override
  List<Object> get props => [signupStatus, error];
}
