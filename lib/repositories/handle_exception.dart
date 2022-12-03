import 'package:firebase_auth/firebase_auth.dart';

import '../models/custom_error.dart';

CustomError handleException(e) {
  try {
    throw e;
  } on FirebaseAuthException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Unknown Auth Error',
      plugin: e.plugin,
    );
  } on FirebaseException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Unknown Firebase Error',
      plugin: e.plugin,
    );
  } catch (e) {
    return CustomError(
      code: 'Exception',
      message: e.toString(),
      plugin: 'flutter-error/server-error',
    );
  }
}
