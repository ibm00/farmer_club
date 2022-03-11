import 'package:easy_localization/easy_localization.dart';
import 'package:farmer_club/data/firebase_services/fire_home.dart';
import 'package:farmer_club/data/models/post_model.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../utils/shared_widgets/snack_bar.dart';

final homePostsProvider = StreamProvider<List<Post>>(
  (ref) {
    return FireHome.getHomePosts().map(
      (postsCollectionSnapshot) => postsCollectionSnapshot.docs
          .map(
            (postsDocSnapshot) => Post.fromJson(postsDocSnapshot.data()),
          )
          .toList(),
    );
  },
);

final addingPostProvider = ChangeNotifierProvider<AddingPostProvider>(
  (ref) => AddingPostProvider(ref.read),
);

class AddingPostProvider extends ChangeNotifier {
  String userImgUrl = "";
  TextEditingController postController = TextEditingController();
  String getPostTxt() => postController.text.trim();
  final formKey = GlobalKey<FormState>();
  String emptyPostError = "";
  final Reader _reader;
  AddingPostProvider(this._reader) {
    userImgUrl = _reader(userDataProvider).imageUrl;
  }

  Future<void> addNewPost(BuildContext context) async {
    if (getPostTxt().isEmpty) {
      showMySnakebar(context, "لا يمكن نشر بوست فارغ");
      return;
    }

    final post = Post(
      commentsNum: 0,
      postText: getPostTxt(),
      userId: _reader(userDataProvider).userId ?? "",
      userImgUrl: userImgUrl,
      userName: _reader(userDataProvider).name ?? "",
      postDate: DateFormat.yMd('ar').format(DateTime.now()),
    );
    // print("data befooooooooore post");
    // print(_reader(userDataProvider).userId);
    // print(_reader(userDataProvider).name);
    _isLoading(true);
    print("loading = trueeee");
    final isDone = await FireHome.addNewPost(post);
    _isLoading(false);
    postController.clear();
    print("loading = false");
    if (isDone) {
      showMySnakebar(context, "تم نشر البوست بنجاح");
    }
  }

  Future<void> deletePost(BuildContext context, String postId) async {
    _isLoading(true);
    await FireHome.deletePost(postId);
    _isLoading(false);
  }

  // Future<void> onPickImagePressed(BuildContext context) async {
  //   final ImagePicker _picker = ImagePicker();
  //   final imageFile = await _picker.pickImage(source: ImageSource.gallery);
  // }

  // Future<void> _uploadFile(String filePath) async {
  //   XFile file = XFile(filePath);

  //   // try {
  //   //   await firebase_storage.FirebaseStorage.instance
  //   //       .ref('uploads/file-to-upload.png')
  //   //       .putFile(file);
  //   // } on firebase_core.FirebaseException catch (e) {
  //   //   // e.g, e.code == 'canceled'
  //   // }
  // }

  bool isLoading = false;
  void _isLoading(bool loadingState) {
    isLoading = loadingState;
    // print("truuueee $isLoading");
    notifyListeners();
  }
}
