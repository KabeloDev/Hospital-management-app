import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  ///AuthService is the same as yours, I just changed the names
  ///of my methods
  final _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn(
        clientId:
            '905883849241-48gj5tvn80kbs00eirsk21bhi5mvr896.apps.googleusercontent.com',
      ).signInSilently();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      final user = await _auth.signInWithCredential(cred);

      return user.user;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  Future<User?> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Signing in user went wrong");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Signing out user went wrong");
    }
  }
}
