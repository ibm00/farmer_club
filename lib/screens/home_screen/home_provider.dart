import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:farmer_club/data/firebase_services/fire_home.dart';
import 'package:farmer_club/data/models/post_model.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/shared_widgets/snack_bar.dart';
import 'components/select_photo_options_widget.dart';

final addingPostProvider = ChangeNotifierProvider<AddingPostProvider>(
  (ref) => AddingPostProvider(ref.read),
);

class AddingPostProvider extends ChangeNotifier {
  TextEditingController homePostController = TextEditingController();
  String getPostTxt() => homePostController.text.trim();
  final Reader _reader;
  AddingPostProvider(this._reader);
  Future<void> addNewPost(BuildContext context) async {
    if (getPostTxt().isEmpty && userImage == null) {
      showMySnakebar(context, "لا يمكن نشر بوست فارغ");
      return;
    }
    String? imageUrl;
    _isNewPostLoading(true);
    if (userImage != null) {
      imageUrl = await _uploadImageToServer();
    }

    final post = Post(
      commentsNum: 0,
      postText: getPostTxt(),
      userId: _reader(userDataProvider).userId ?? "",
      postImage: imageUrl ?? "",
      userImgUrl: _reader(userDataProvider).imageUrl,
      userName: _reader(userDataProvider).name ?? "",
      postDate: DateFormat.yMd('ar').format(DateTime.now()),
    );

    final postsNum = await FireHome.addNewPost(post);
    _isNewPostLoading(false);
    clearPostDialog();
    notifyListeners();
    if (postsNum != null) {
      showMySnakebar(context, "تم نشر البوست بنجاح");
      _reader(userDataProvider).updatePostsNum(postsNum);
    }
  }

  void clearPostDialog() {
    _userImage = null;
    homePostController.text = '';
    notifyListeners();
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

  ImageProvider? _userImage;
  ImageProvider? get userImage => _userImage;
  File? _userImageFile;

  Future<void> pickImage(BuildContext context) async {
    try {
      final sellectedImgPickerSource = await _showModelSheet(context);
      final ImagePicker _picker = ImagePicker();

      if (sellectedImgPickerSource != null) {
        final pickedFile = await _picker.pickImage(
          source: sellectedImgPickerSource,
          imageQuality: 20,
        );
        _userImageFile = File(pickedFile!.path);
        _userImage = FileImage(_userImageFile!);
      }
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<ImageSource?> _showModelSheet(BuildContext context) async {
    final imageType = await showModalBottomSheet<ImageSource>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return const SelectPhotoOptionsWidget();
      },
    );
    return imageType;
  }

  Future<String?> _uploadImageToServer() async {
    final imageUrl = await FireHome.uploadPostImage(
      userImage: _userImageFile!,
    );
    return imageUrl;
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

  bool isLoadingNewPost = false;
  void _isNewPostLoading(bool loadingState) {
    isLoadingNewPost = loadingState;
    // print("truuueee $isLoading");
    notifyListeners();
  }
}
