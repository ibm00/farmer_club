import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../screens/login_screen/login_screen.dart';

class FireAuth {
  static Future<String?> signUp(UserModel user, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: user.email ?? "",
        password: password,
      );
      _saveUserDataToFirebase(user, userCredential);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    } catch (e) {
      return null;
    }
  }

  static Future<String?> signin(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user == null ? null : userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> signout(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (route) => false,
      );
      return true;
    } catch (e) {
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
      "followingsNum": user.followingsNum,
      "followersNum": user.followersNum,
      "postsNum": user.postsNum,
    });
  }

  static Future<String?> uploadUserImage({
    required File userImage,
  }) async {
    try {
      final imageReference = FirebaseStorage.instance.ref().child(
            'users_images/${userImage.path.split('/').last}',
          );
      await imageReference.putFile(userImage);
      final imgUrl = await imageReference.getDownloadURL();
      return imgUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // static Future<void> sign
}
