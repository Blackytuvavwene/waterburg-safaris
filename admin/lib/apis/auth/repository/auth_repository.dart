import 'package:admin/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';

// auth repository class that implements auth abstract
class AuthRepository extends AuthAbstract {
  // firebase auth instance
  final _auth = FirebaseAuth.instance;

  // login in method override
  @override
  Future<void> login({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  // logout in method override
  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  // signup in method override
  @override
  Future<void> signup({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }
}
