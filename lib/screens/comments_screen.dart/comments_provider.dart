import 'package:farmer_club/data/firebase_services/fire_comments.dart';
import 'package:farmer_club/data/models/comment_model.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/shared_widgets/snack_bar.dart';

final getCommentsProvider = StreamProvider.family<List<Comment>, String>(
  (ref, postId) {
    print("جوا البروفايدر postId: $postId");
    var x = FireComments.getComments(postId).map(
      (commentsCollectionSnapshot) => commentsCollectionSnapshot.docs
          .map(
            (commentDocSnapshot) => Comment.fromJson(
              commentDocSnapshot.data(),
            ),
          )
          .toList(),
    );
    print("request donnnnnnnneeeeeeeeeeeee");
    print(x.elementAt(0));
    return x;
  },
);
final addingCommentProvider =
    ChangeNotifierProvider.family<AddingCommentProvider, String>(
  (ref, postId) => AddingCommentProvider(ref.read, postId),
);

class AddingCommentProvider extends ChangeNotifier {
  AddingCommentProvider(this._reader, this.postId);
  TextEditingController commentController = TextEditingController();
  String getCommentTxt() => commentController.text.trim();
  final Reader _reader;
  final String postId;

  Future<void> addNewComment(BuildContext context) async {
    if (getCommentTxt().isEmpty) {
      showMySnakebar(context, "لا يمكن نشر تعليق فارغ");
      return;
    }

    final comment = Comment(
      commentDate: DateTime.now(),
      commentText: getCommentTxt(),
      postId: postId,
      userId: _reader(userDataProvider).userId,
      userImage: _reader(userDataProvider).imageUrl,
      userName: _reader(userDataProvider).name,
    );
    // print("data befooooooooore post");
    // print(_reader(userDataProvider).userId);
    // print(_reader(userDataProvider).name);
    _isLoading(true);
    print("loading = trueeee");
    final isDone = await FireComments.addNewComment(comment);
    _isLoading(false);
    commentController.clear();
    print("loading = false");
    if (isDone) {
      showMySnakebar(context, "تم نشر البوست بنجاح");
    }
  }

  Future<void> deleteComment(BuildContext context, Comment comment) async {
    _isLoading(true);
    await FireComments.deleteComment(comment);
    _isLoading(false);
  }

  bool isLoading = false;
  void _isLoading(bool loadingState) {
    isLoading = loadingState;
    // print("truuueee $isLoading");
    notifyListeners();
  }
}
