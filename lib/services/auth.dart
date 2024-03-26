import 'package:classconnect/utilities/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = cred.user;
      if (user != null) {
        return Response(status: ResponseType.success);
      } else {
        return Response(status: ResponseType.error);
      }
    } on FirebaseAuthException catch (e) {
      return Response(status: ResponseType.error, message: e.message);
    }
  }

  //is User logged In
  bool isLoggedIn() {
    final User? user = _auth.currentUser;
    return user != null;
  }

  //create user
  Future<Response> signUp(
      {required String fname,
      String? lname,
      required String email,
      required String password}) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      final User? user = cred.user;
      if (user != null) {
        return Response(status: ResponseType.success);
      } else {
        return Response(status: ResponseType.error);
      }
    } on FirebaseAuthException catch (e) {
      return Response(status: ResponseType.error, message: e.message);
    }
  }

  //Sign out
  Future<void> signOut() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      await _auth.signOut();
    }
  }
}
