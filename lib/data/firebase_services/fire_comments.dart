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
      final commentCollection =
          _firestoreInistance.collection('posts/${comment.postId}/comments');
      final commentDoc = commentCollection.doc();
      commentDoc.set(
        comment.toJson()
          ..addAll({
            "commentId": commentDoc.id,
            "createdAt": Timestamp.now(),
          }),
      );
      final commentsDocs = await commentCollection.get();
      final int commentsNum = commentsDocs.size;
      _updateCommentsNum(comment.postId!, commentsNum);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  static Future<bool> deleteComment(Comment comment) async {
    try {
      // print('posts/${comment.postId}/comments/${comment.commentId}');
      final commentCollection =
          _firestoreInistance.collection('posts/${comment.postId}/comments');
      await commentCollection.doc(comment.commentId).delete();
      final commentsDocs = await commentCollection.get();
      final int commentsNum = commentsDocs.size;
      _updateCommentsNum(comment.postId!, commentsNum);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  static Future<void> _updateCommentsNum(String postId, int commentsNum) async {
    final _firestoreInistance = FirebaseFirestore.instance;
    await _firestoreInistance
        .doc('posts/$postId')
        .update({"commentsNum": commentsNum});
    // commentsNum = comments.size;
    // commentsNum =
  }
}
