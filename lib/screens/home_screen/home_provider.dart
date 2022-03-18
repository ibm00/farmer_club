import 'package:easy_localization/easy_localization.dart';
import 'package:farmer_club/data/firebase_services/fire_home.dart';
import 'package:farmer_club/data/models/post_model.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/shared_widgets/snack_bar.dart';

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
    _isLoading(true);
    final postsNum = await FireHome.addNewPost(post);
    _isLoading(false);
    postController.clear();
    if (postsNum != null) {
      showMySnakebar(context, "تم نشر البوست بنجاح");
      _reader(userDataProvider).updatePostsNum(postsNum);
    }
  }

  Future<void> deletePost(BuildContext context, String postId) async {
    _isLoading(true);
    final postsNum =
        await FireHome.deletePost(postId, _reader(userDataProvider).userId!);
    _isLoading(false);
    if (postsNum != null) {
      showMySnakebar(context, "تم حذف البوست بنجاح");
      _reader(userDataProvider).updatePostsNum(postsNum);
    }
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
