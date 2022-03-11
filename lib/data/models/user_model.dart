import 'package:flutter/cupertino.dart';

class UserModel {
  String? name;
  String? userId;
  String? email;
  String imageUrl;
  int followingsNum;
  int followersNum;

  UserModel({
    this.name,
    this.email,
    this.userId,
    this.followingsNum = 0,
    this.followersNum = 0,
    this.imageUrl =
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  });
}
