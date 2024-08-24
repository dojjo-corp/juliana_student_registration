import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final auth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signup(
      {required String email, required String password}) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credentials;
    } catch (e) {
      rethrow;
    }
  }
}
