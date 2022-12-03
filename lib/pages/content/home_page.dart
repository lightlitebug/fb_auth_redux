import 'package:fb_auth_redux/utils/error_dialog.dart';
import 'package:flutter/material.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';

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
        child: Text('Home'),
      ),
    );
  }
}
