import 'dart:io';

import 'package:farmer_club/data/firebase_services/fire_auth.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/shared_widgets/snack_bar.dart';
import '../home_screen/components/select_photo_options_widget.dart';
import '../home_screen/home_screen.dart';

final registerProvider = ChangeNotifierProvider.autoDispose<UserProvider>(
  (ref) => UserProvider(ref.read),
);

class UserProvider extends ChangeNotifier {
  final Reader reader;
  UserProvider(this.reader);
  final formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();

  String _name = "";
  String _email = "";
  String _password = "";
  // int _followingsNum = 0;
  // int _followersNum = 0;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  // int get followingsNum => _followingsNum;
  // int get followersNum => _followersNum;

  set setName(String name) => _name = name.trim();
  set setEmail(String email) => _email = email.trim();
  set setPassword(String password) => _password = password.trim();
  // set setFollowingsNum(int followingsNum) => _followingsNum = followingsNum;
  // set setFollowersNum(int followersNum) => _followersNum = followersNum;

  Future<void> onRegisterPressed(BuildContext context) async {
    if (_userImage == null) {
      showMySnakebar(context, "من فضلك أختار صورة شخصية");
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final isRegisterSuccess = await singup(context);
      if (isRegisterSuccess) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    }
  }

  Future<bool> singup(BuildContext context) async {
    final user = reader(userDataProvider);
    user.name = _name;
    user.email = _email;

    // final user = UserModel(
    //   name: _name,
    //   email: _email,
    //   followingsNum: 0,
    //   followersNum: 0,
    // );
    _isLoading(true);
    try {
      final userImageUrl = await _uploadImageToServer();
      user.imageUrl = userImageUrl!;
      final userId = await FireAuth.signUp(user, password);
      _isLoading(false);
      if (userId != null) user.userId = userId;
      return true;
    } catch (e) {
      _isLoading(false);
      showMySnakebar(context, e.toString());
      return false;
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
    final imageUrl = await FireAuth.uploadUserImage(userImage: _userImageFile!);
    return imageUrl;
  }

  bool isLoading = false;
  void _isLoading(bool loadingState) {
    isLoading = loadingState;
    notifyListeners();
  }
}
