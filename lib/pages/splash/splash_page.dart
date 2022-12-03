import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../repositories/auth_repository.dart';
import '../auth/signin_page.dart';
import '../auth/signup_page.dart';
import '../auth/verify_email_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthRepository.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        User? user = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Firebase Connection Error\n\nTry later!',
                style: TextStyle(fontSize: 18.0, color: Colors.red),
              ),
            ),
          );
        } else if (user != null) {
          return const VerifyEmailPage();
        } else {
          return const SigninPage();
        }
      },
    );
  }
}
