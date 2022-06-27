import 'dart:io';
import 'package:farmer_club/utils/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/firebase_services/fire_home.dart';
import '../../../utils/shared_widgets/snack_bar.dart';
import 'select_photo_options_widget.dart';

final editPostProvider =
    ChangeNotifierProvider.autoDispose.family<EditPostProvider, Map>(
  (ref, dataMap) => EditPostProvider(dataMap),
);

class EditPostProvider extends ChangeNotifier {
  late TextEditingController postTextController;
  late String imageUrl;
  late String postId;
  EditPostProvider(Map dataMap) {
    postTextController = TextEditingController(text: dataMap["postText"]);
    imageUrl = dataMap["imageUrl"];
    postId = dataMap["postId"];
  }

  String getPostTxt() => postTextController.text.trim();

  Future<void> editPost(BuildContext context) async {
    String? newImageUrl;

    if (userImage != null) {
      newImageUrl = await _uploadImageToServer();
    }

    await FireHome.updatePost({
      "postId": postId,
      "postText": getPostTxt(),
      "imageUrl": newImageUrl ?? imageUrl,
    });

    // if (isDone) {
    // showMySnakebar(
    //   context,
    //   "تم حفظ البوست بنجاح",
    // );
    // }
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
          imageQuality: 15,
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
}
