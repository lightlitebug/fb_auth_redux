import 'dart:async';

import 'package:fb_auth_redux/pages/content/home_page.dart';
import 'package:flutter/material.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';
import '../../utils/error_dialog.dart';

class VerifyEmailPage extends StatefulWidget {
  static const String routeName = '/verify-email';
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool emailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    emailVerified = AuthRepository.emailVerified!;
    if (emailVerified != true) {
      sendEmailVerification();
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> sendEmailVerification() async {
    try {
      await AuthRepository.instance.sendEmailVerification();
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      await AuthRepository.instance.reloadUser();
      setState(() {
        emailVerified = AuthRepository.emailVerified!;
      });
      if (emailVerified) {
        timer?.cancel();
      }
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (emailVerified) {
      return const HomePage();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text('Verification email has been sent to'),
                  Text('${AuthRepository.currentUser!.email}.'),
                  const Text('If you cannot find verification email,'),
                  RichText(
                    text: TextSpan(
                      text: 'Please Check ',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontSize: 18.0),
                      children: const [
                        TextSpan(
                          text: 'SPAM',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: ' folder.'),
                      ],
                    ),
                  ),
                  const Text('or, your email is correct.'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await AuthRepository.instance.signout();
                  timer?.cancel();
                } on CustomError catch (e) {
                  errorDialog(context, e);
                }
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
