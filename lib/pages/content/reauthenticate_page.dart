import 'package:flutter/material.dart';

class ReauthenticatePage extends StatefulWidget {
  const ReauthenticatePage({Key? key}) : super(key: key);

  @override
  State<ReauthenticatePage> createState() => _ReauthenticatePageState();
}

class _ReauthenticatePageState extends State<ReauthenticatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reauthenticate'),
      ),
      body: Center(
        child: Text('Reauthenticate'),
      ),
    );
  }
}
