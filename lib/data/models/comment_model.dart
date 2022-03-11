import 'package:firebase_auth/firebase_auth.dart';

class Comment {
  String? userImage;
  String? userName;
  DateTime? commentDate;
  String? commentText;
  String? commentId;
  String? postId;
  String? userId;
  late bool isMyComment;
  Comment({
    this.userImage,
    this.userName,
    this.commentDate,
    this.commentText,
    this.commentId,
    this.userId,
    this.postId,
  }) {
    isMyComment = (userId == FirebaseAuth.instance.currentUser!.uid);
  }

  Comment.fromJson(Map<String, dynamic> json) {
    userImage = json['userImage'] ?? "";
    userName = json['userName'] ?? "";
    userId = json['userId'] ?? "";
    commentText = json['commentText'] ?? "";
    // userName = json['userName'] ?? "";
    commentId = json['commentId'] ?? "";
    postId = json['postId'] ?? "";
    commentDate = json['commentDate'] == null
        ? null
        : DateTime.parse(json['commentDate']);

    isMyComment = userId == FirebaseAuth.instance.currentUser!.uid;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userImage'] = userImage ??
        "https://th.bing.com/th/id/OIP.w8-nMMOuUD3gSHx8yyDVJQHaFj?pid=ImgDet&rs=1";
    data['userName'] = userName;
    data['userId'] = userId;
    data['commentText'] = commentText;
    // data['docId'] = commentId;
    data['postId'] = postId;
    data['commentDate'] = commentDate!.toIso8601String();
    return data;
  }
}
