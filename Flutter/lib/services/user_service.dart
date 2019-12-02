import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_design_plantlanta/model/user.dart';


class UserService {
  String uid;
  StreamController<UserModel> userModelStream = StreamController();

  void dispose() {
    userModelStream.close();
  }

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

  Stream getOtherUserAuth(String uid) {
    if (uid == null) {
      return Stream.empty();
    }
    return Firestore.instance.collection("Users").document(uid).get().asStream();
  }

  StreamController<UserModel> getUserModelStream() {
    return userModelStream;
  }
}