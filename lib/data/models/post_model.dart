import 'package:firebase_auth/firebase_auth.dart';

class Post {
  late int commentsNum;
  late String postText;
  late String userId;
  late String userImgUrl;
  late String userName;
  late String docId;
  late String postDate;
  late bool isMyPost;

  Post({
    required this.commentsNum,
    required this.postText,
    required this.userId,
    required this.userImgUrl,
    required this.userName,
    required this.docId,
    required this.postDate,
  }) {
    isMyPost = userId == FirebaseAuth.instance.currentUser!.uid;
  }

  Post.fromJson(Map<String, dynamic> json) {
    commentsNum = json['commentsNum'] ?? 0;
    postText = json['postText'] ?? "";
    userId = json['userId'] ?? "";
    userImgUrl = json['userImgUrl'] ?? "";
    userName = json['userName'] ?? "";
    docId = json['docId'] ?? "";
    postDate = json['postDate'] ?? "";
    isMyPost = userId == FirebaseAuth.instance.currentUser!.uid;
    // isMyPost = json['isMyPost'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentsNum'] = commentsNum;
    data['postText'] = postText;
    data['userId'] = userId;
    data['userImgUrl'] = userImgUrl;
    data['userName'] = userName;
    data['docId'] = docId;
    data['postDate'] = postDate;
    // data['isMyPost'] = isMyPost;
    return data;
  }
}
