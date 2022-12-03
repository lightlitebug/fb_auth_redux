import 'package:fb_auth_redux/pages/content/home_page.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  static const String routeName = '/verify-email';
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool emailVerified = true;

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
        child: Text('Verify Email'),
      ),
    );
  }
}
