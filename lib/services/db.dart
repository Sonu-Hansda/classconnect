import 'package:classconnect/models/user.dart';
import 'package:classconnect/utilities/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  late FirebaseFirestore _firesotre;
  late CollectionReference _userRef;
  DatabaseService() {
    _firesotre = FirebaseFirestore.instance;
    _userRef = _firesotre.collection('users');
  }
  addUserData(UserModel user) async {
    try {
      DocumentReference docRef = await _userRef.add(user.toJson());
      await docRef.update({'id': docRef.id});
      return Response(status: ResponseType.success);
    } catch (e) {
      return Response(
          status: ResponseType.error, message: 'Error while adding user data');
    }
  }
}
