import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaxio/utils/utils.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<void> login(String email, String password) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: password.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());

      Get.toNamed('/Home');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }

  void signUp(String email, String password, String mobile, String username) {
    _auth
        .createUserWithEmailAndPassword(
            email: email, password: password.toString())
        .then((authResult) async {
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user?.uid)
          .set({
        'uid': user?.uid,
        'username': username.toString(),
        'email': email.toString(),
        'mobile': mobile.toString(),
        'password': password.toString()

        // You may want to store additional user information here
      }).then((value) {
        Get.toNamed('/LogMove');
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
      }).catchError((error) {
        // Handle Firebase Authentication error
        Utils().toastMessage("Error creating user: $error");
      });
    });
  }
}
