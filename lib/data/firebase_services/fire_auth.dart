import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../screens/login_screen/login_screen.dart';

class FireAuth {
  static Future<bool> signUp(UserModel user, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      _saveUserDataToFirebase(user, userCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw (e.code);
    } catch (e) {
      print("signin error$e");
      return false;
    }
  }

  static Future<bool> signin(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw (e.code);
    } catch (e) {
      print("signin error$e");
      return false;
    }
  }

  static Future<bool> signout(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      return true;
    } catch (e) {
      print("sinout error$e");
      return false;
    }
  }

  // void handleThrow(FirebaseAuthException error) {
  //   switch (error.code) {
  //     case "email-already-in-use":
  //       throw ("");
  //     case "weak-password":
  //       break;
  //     case "invalid-email":
  //       break;
  //     case "operation-not-allowed":
  //       break;
  //     default:
  //   }
  // }

  static void _saveUserDataToFirebase(
      UserModel user, UserCredential userCredential) {
    final fireStore =
        FirebaseFirestore.instance.doc('users/${userCredential.user!.uid}');
    fireStore.set({
      "email": user.email,
      "name": user.name,
      "imageUrl": user.imageUrl,
    });
    print("user data saved");
  }

  // static Future<void> sign
}
