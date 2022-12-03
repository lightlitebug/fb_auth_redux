import 'package:firebase_auth/firebase_auth.dart';

import '../constants/firebase_constants.dart';
import 'handle_exception.dart';

class AuthRepository {
  AuthRepository._();
  static final AuthRepository _instance = AuthRepository._();
  static AuthRepository get instance => _instance;

  static Stream<User?> get userStream => fbAuth.authStateChanges();
  static User? get currentUser => fbAuth.currentUser;
  static String? get uid => fbAuth.currentUser?.uid;
  static bool? get emailVerified => fbAuth.currentUser?.emailVerified;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final signedInUser = userCredential.user!;

      await usersCollection.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> signout() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      throw handleException(e);
    }
  }
}
