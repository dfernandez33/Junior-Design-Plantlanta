import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserService {
  String uid;

  UserService() {
    _getUid();
  }

  Future<void> _getUid() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      this.uid = user.uid;
    });
  }

  Stream getUserAuth() {
    if (this.uid == null) {
      return Stream.empty();
    }
    return Firestore.instance.collection("Users").document(this.uid).get().asStream();
  }
}