class Post {
  final String userName;
  final String userImageUrl;
  final String postDate;
  final String? postText;
  final String? postImageUrl;
  final int commentsNum;
  final bool isMyPost;
  Post({
    required this.userName,
    required this.userImageUrl,
    required this.postDate,
    required this.commentsNum,
    required this.isMyPost,
    this.postText,
    this.postImageUrl,
  });
}
