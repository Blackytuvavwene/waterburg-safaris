import 'package:admin/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';

// auth repository class that implements auth abstract
class AuthRepository extends AuthAbstract {
  // firebase auth instance
  final _auth = FirebaseAuth.instance;

  // login in method override
  @override
  Future<User> login({String? email, String? password}) async {
    try {
      final data = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      final user = data.user;
      return user!;
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
  Future<UserCredential> signup({String? email, String? password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  // is signed in method
  @override
  Stream<User?> isSignedIn() => _auth.userChanges();
}
