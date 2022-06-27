// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireHome {
  static final firestoreInistance = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getHomePosts() {
    final postsCollectionRef = firestoreInistance.collection('posts').orderBy(
          "createdAt",
          descending: true,
        );
    return postsCollectionRef.snapshots();
  }

  static Future<int?> addNewPost(Post post) async {
    try {
      final postsCollection = firestoreInistance.collection('posts');
      final postDoc = postsCollection.doc();
      await postDoc.set(
        post.toJson()
          ..addAll({
            "docId": postDoc.id,
            "createdAt": Timestamp.now(),
          }),
      );
      final postsDocs = await postsCollection.get();
      final allPosts = postsDocs.docs;
      int userPostsnum = 0;
      for (var postDoc in allPosts) {
        if (postDoc.data()['userId'] == post.userId) {
          userPostsnum++;
        }
      }
      _updatePostsNum(post.userId, userPostsnum);
      return userPostsnum;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> updatePost(Map postData) async {
    try {
      final postsCollection = firestoreInistance.collection('posts');
      postsCollection.doc(postData["postId"]).update({
        "postText": postData["postText"],
        "postImage": postData["imageUrl"],
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<int?> deletePost(String postID, String userId) async {
    try {
      final postsCollection = firestoreInistance.collection('posts');
      await postsCollection.doc(postID).delete();
      final postsDocs = await postsCollection.get();
      final allPosts = postsDocs.docs;
      int userPostsnum = 0;
      for (var postDoc in allPosts) {
        if (postDoc.data()['userId'] == userId) {
          userPostsnum++;
        }
      }
      _updatePostsNum(userId, userPostsnum);
      return userPostsnum;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> _updatePostsNum(String userId, int postsNum) async {
    final _firestoreInistance = FirebaseFirestore.instance;
    await _firestoreInistance
        .doc('users/$userId')
        .update({"postsNum": postsNum});
  }

  static Future<String?> uploadPostImage({
    required File userImage,
  }) async {
    try {
      final imageReference = FirebaseStorage.instance.ref().child(
            'posts_images/${userImage.path.split('/').last}',
          );
      await imageReference.putFile(userImage);
      final imgUrl = await imageReference.getDownloadURL();
      return imgUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // static Future<String?> updatePostImage({
  //   required File userImage,
  //   required userId,
  // }) async {
  //   try {
  //     final imageReference = FirebaseStorage.instance.ref().child(
  //           'posts_images/${userImage.path.split('/').last}',
  //         );
  //     await imageReference.putFile(userImage);
  //     final imgUrl = await imageReference.getDownloadURL();
  //     return imgUrl;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return null;
  // }
}
