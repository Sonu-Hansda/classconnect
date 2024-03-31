import 'package:classconnect/models/user.dart';
import 'package:classconnect/utilities/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Response> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = cred.user;
      if (user != null) {
        if (user.emailVerified) {
          return Response(status: ResponseType.success);
        }
        return Response(
            status: ResponseType.error, message: 'email-not-verified');
      } else {
        return Response(status: ResponseType.error, message: 'user-not-found');
      }
    } on FirebaseAuthException catch (e) {
      return Response(
        status: ResponseType.error,
        message: e.code == 'invalid-credential'
            ? 'Invalid email or password'
            : e.message,
      );
    }
  }

  Future<Response> sendVerificationMail(String email, String password) async {
    User? user = _auth.currentUser;
    if (user == null) {
      try {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        user = cred.user;
      } catch (e) {
        return Response(status: ResponseType.error, message: 'user-not-found');
      }
    }
    await user!.sendEmailVerification();
    return Response(status: ResponseType.success);
  }

  //is User logged In
  bool isLoggedIn() {
    final User? user = _auth.currentUser;
    return user != null && user.emailVerified;
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
        if (!user.emailVerified) await user.sendEmailVerification();
        Map<String, dynamic>? emailData = extractEmailInfo(email);
        UserModel userData = UserModel(
          registrationNumber: emailData?['registrationNumber'],
          batch: emailData?['batch'],
          branch: emailData?['branch'],
          email: email,
          firstName: fname,
          lastName: lname,
          isCR: false,
          profileImage: null,
          id: user.uid,
        );
        try {
          await _firestore.collection('users').add(userData.toJson());
          return Response(status: ResponseType.success);
        } catch (e) {
          return Response(status: ResponseType.error);
        }
      } else {
        return Response(status: ResponseType.error);
      }
    } on FirebaseAuthException catch (e) {
      return Response(status: ResponseType.error, message: e.message);
    }
  }

  Map<String, dynamic>? extractEmailInfo(String email) {
    if (email.contains('@') && email.endsWith('nitjsr.ac.in')) {
      Map<String, String> branches = {
        'cs': 'Computer Science Engineering',
        'ec': 'Electronics and Communication Engineering',
        'ee': 'Electrical Engineering',
        'cm': 'Engineering and Computational Mechanics',
        'ce': 'Civil Engineering',
        'pi': 'Production Engineering',
        'mm': 'Material and Metallurgical Engineering',
      };

      String registrationNumber = email.split('@')[0];
      String branchCode = registrationNumber.substring(6, 8);
      String branch = branches[branchCode] ?? 'Unknown Branch';
      String batch = registrationNumber.substring(0, 4);
      return {
        'registrationNumber': registrationNumber,
        'branch': branch,
        'batch': int.parse(batch),
      };
    } else {
      return null;
    }
  }

  //Sign out
  Future<Response> signOut() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _auth.signOut();
        return Response(status: ResponseType.success);
      } catch (e) {
        return Response(status: ResponseType.error);
      }
    }
    return Response(status: ResponseType.error);
  }
}
