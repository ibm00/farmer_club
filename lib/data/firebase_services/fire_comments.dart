import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/models/comment_model.dart';

class FireComments {
  static final _firestoreInistance = FirebaseFirestore.instance;
  static Stream<QuerySnapshot<Map<String, dynamic>>> getComments(
    String postId,
  ) {
    final postsCollectionRef = _firestoreInistance
        .collection(
          'posts/$postId/comments',
        )
        .orderBy(
          "createdAt",
          descending: true,
        );
    return postsCollectionRef.snapshots();
  }

  static Future<bool> addNewComment(Comment comment) async {
    try {
      final commentDoc = _firestoreInistance
          .collection('posts/${comment.postId}/comments')
          .doc();
      commentDoc.set(
        comment.toJson()
          ..addAll({
            "commentId": commentDoc.id,
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

  static Future<bool> deleteComment(Comment comment) async {
    try {
      print('posts/${comment.postId}/comments/${comment.commentId}');
      await _firestoreInistance
          .doc('posts/${comment.postId}/comments/${comment.commentId}')
          .delete();
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
