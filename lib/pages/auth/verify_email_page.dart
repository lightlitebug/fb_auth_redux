import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  static const String routeName = '/verify-email';
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
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
