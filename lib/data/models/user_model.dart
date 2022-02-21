class UserModel {
  final String name;
  final String email;
  final String imageUrl;
  final int followingsNum;
  final int followersNum;

  UserModel({
    required this.name,
    required this.email,
    required this.followingsNum,
    required this.followersNum,
    this.imageUrl =
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  });
}
