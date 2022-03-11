import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/post_model.dart';

class FireHome {
  static final firestoreInistance = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getHomePosts() {
    final postsCollectionRef = firestoreInistance.collection('posts').orderBy(
          "createdAt",
          descending: true,
        );
    return postsCollectionRef.snapshots();
  }

  static Future<bool> addNewPost(Post post) async {
    try {
      final postDoc = firestoreInistance.collection('posts').doc();
      postDoc.set(
        post.toJson()
          ..addAll({
            "docId": postDoc.id,
            "createdAt": Timestamp.now(),
          }),
      );
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  static Future<bool> deletePost(String postID) async {
    try {
      await firestoreInistance.doc('posts/$postID').delete();
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
// final i = FirebaseFirestore.instance.collection("posts").doc();
//   i.set({"data": i.id});
  // Timestamp.now()
}
