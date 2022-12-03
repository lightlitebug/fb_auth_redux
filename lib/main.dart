import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'firebase_options.dart';
import 'pages/auth/signin_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/auth/verify_email_page.dart';
import 'pages/splash/splash_page.dart';
import 'redux/app_middleware.dart';
import 'redux/app_reducer.dart';
import 'redux/app_state.dart';

late final Store<AppState> store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  store = Store<AppState>(
    reducer,
    initialState: AppState.initial(),
    middleware: appMiddleware(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Redux FB Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          SigninPage.routeName: (context) => const SigninPage(),
          SignupPage.routeName: (context) => const SignupPage(),
          VerifyEmailPage.routeName: (context) => const VerifyEmailPage(),
        },
      ),
    );
  }
}
