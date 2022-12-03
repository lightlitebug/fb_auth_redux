import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../models/custom_error.dart';
import '../../redux/app_state.dart';
import '../../redux/signin/signin_action.dart';
import '../../redux/signin/signin_state.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/form_fields.dart';
import 'reset_password_page.dart';
import 'signup_page.dart';

class SigninPage extends StatefulWidget {
  static const String routeName = '/signin';
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    StoreProvider.of<AppState>(context).dispatch(
      signinAndDispatch(
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
                  EmailFormField(emailController: _emailController),
                  const SizedBox(height: 20.0),
                  PasswordFormField(
                    passwordController: _passwordController,
                    labelText: 'Password',
                  ),
                  const SizedBox(height: 20.0),
                  StoreConnector<AppState, _ViewModel>(
                    distinct: true,
                    onWillChange: (_ViewModel? prev, _ViewModel current) {
                      if (current.signinStatus == SigninStatus.failure) {
                        errorDialog(context, current.error);
                      }
                    },
                    converter: (Store<AppState> store) =>
                        _ViewModel.fromStore(store),
                    builder: (BuildContext context, _ViewModel vm) {
                      final SigninStatus status = vm.signinStatus;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: status == SigninStatus.submitting
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
                              status == SigninStatus.submitting
                                  ? 'Submitting...'
                                  : 'Sign In',
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            height: 20.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Not a member? '),
                                TextButton(
                                  onPressed: status == SigninStatus.submitting
                                      ? null
                                      : () => Navigator.of(context)
                                          .pushNamed(SignupPage.routeName),
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    textStyle: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('Sign Up!'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            height: 20.0,
                            child: TextButton(
                              onPressed: status == SigninStatus.submitting
                                  ? null
                                  : () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const ResetPasswordPage();
                                          },
                                        ),
                                      );
                                    },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                textStyle: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Forgot Password?'),
                            ),
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
  final SigninStatus signinStatus;
  final CustomError error;
  const _ViewModel({
    required this.signinStatus,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      signinStatus: store.state.signinState.signinStatus,
      error: store.state.signinState.error,
    );
  }

  @override
  List<Object> get props => [signinStatus, error];
}
