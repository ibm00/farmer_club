import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? name;
  String? userId;
  String? email;
  String imageUrl;
  int followingsNum;
  int followersNum;
  int postsNum;
  bool isCurrentUserFollowThisUser = false;

  UserModel({
    this.name,
    this.email,
    this.userId,
    this.followingsNum = 0,
    this.followersNum = 0,
    this.postsNum = 0,
    this.imageUrl =
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  });
  void updatePostsNum(int postsNum) {
    this.postsNum = postsNum;
    notifyListeners();
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      userId: map['userId'],
      email: map['email'],
      imageUrl: map['imageUrl'] ?? '',
      followingsNum: map['followingsNum']?.toInt() ?? 0,
      followersNum: map['followersNum']?.toInt() ?? 0,
      postsNum: map['postsNum']?.toInt() ?? 0,
    );
  }

  void setFollowingState(List<String> currentUserFollowing, [String? userId]) {
    // print(currentUserFollowing);
    if (currentUserFollowing.contains(userId ?? this.userId)) {
      isCurrentUserFollowThisUser = true;
    }
  }
}
