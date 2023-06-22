import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthAbstract {
  // login method
  Future<User> login({
    String? email,
    String? password,
  });

  // logout method
  Future<void> logout();

  // signup method
  Future<UserCredential> signup({
    String email,
    String password,
  });

  // stream user changes
  Stream<User?> isSignedIn();
}
