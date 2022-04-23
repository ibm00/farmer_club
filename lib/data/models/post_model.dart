import 'package:firebase_auth/firebase_auth.dart';

class Post {
  int? commentsNum;
  late String postText;
  late String userId;
  String? userImgUrl;
  String? postImage;
  late String userName;
  String? postId;
  late String postDate;
  String? createdAt;
  late bool isMyPost;

  Post({
    this.commentsNum,
    required this.postText,
    required this.userId,
    required this.userImgUrl,
    required this.postImage,
    required this.userName,
    this.postId,
    required this.postDate,
    this.createdAt,
  }) {
    isMyPost = (userId == FirebaseAuth.instance.currentUser!.uid);
  }

  Post.fromJson(Map<String, dynamic> json) {
    commentsNum = json['commentsNum'] ?? 0;
    postText = json['postText'] ?? "";
    userId = json['userId'] ?? "";
    userImgUrl = json['userImgUrl'] ?? "";
    postImage = json['postImage'] ?? "";
    userName = json['userName'] ?? "";
    postId = json['docId'] ?? "";
    postDate = json['postDate'] ?? "";

    // createdAt = json['createdAt'] ?? "";
    isMyPost = userId == FirebaseAuth.instance.currentUser!.uid;
    // isMyPost = json['isMyPost'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentsNum'] = commentsNum;
    data['postText'] = postText;
    data['userId'] = userId;
    data['userImgUrl'] = userImgUrl ?? "";
    data['postImage'] = postImage ?? "";
    data['userName'] = userName;
    data['docId'] = postId;
    data['postDate'] = postDate;
    // data['createdAt'] = createdAt;
    // data['isMyPost'] = isMyPost;
    return data;
  }
}
