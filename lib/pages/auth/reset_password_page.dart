import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../models/custom_error.dart';
import '../../redux/app_state.dart';
import '../../redux/reset_password/reset_password_action.dart';
import '../../redux/reset_password/reset_password_state.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/form_fields.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    StoreProvider.of<AppState>(context).dispatch(
      resetPasswordAndDispatch(
        _emailController.text.trim(),
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
          title: const Text('Reset Password'),
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
                  EmailFormField(emailController: _emailController),
                  const SizedBox(height: 20.0),
                  StoreConnector<AppState, _ViewModel>(
                    distinct: true,
                    onWillChange: (_ViewModel? prev, _ViewModel current) {
                      if (current.resetPasswordStatus ==
                          ResetPasswordStatus.failure) {
                        errorDialog(context, current.error);
                      }
                      if (prev!.resetPasswordStatus ==
                              ResetPasswordStatus.submitting &&
                          current.resetPasswordStatus ==
                              ResetPasswordStatus.success) {
                        Navigator.of(context).pop('success');
                      }
                    },
                    converter: (Store<AppState> store) =>
                        _ViewModel.fromStore(store),
                    builder: (BuildContext context, _ViewModel vm) {
                      final ResetPasswordStatus status = vm.resetPasswordStatus;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: status == ResetPasswordStatus.submitting
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
                              status == ResetPasswordStatus.submitting
                                  ? 'Submitting...'
                                  : 'Reset Password',
                            ),
                          ),
                          const SizedBox(height: 10.0),
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
  final ResetPasswordStatus resetPasswordStatus;
  final CustomError error;
  const _ViewModel({
    required this.resetPasswordStatus,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      resetPasswordStatus: store.state.resetPasswordState.resetPasswordStatus,
      error: store.state.resetPasswordState.error,
    );
  }

  @override
  List<Object> get props => [resetPasswordStatus, error];
}
