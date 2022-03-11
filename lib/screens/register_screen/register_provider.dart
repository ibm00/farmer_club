import 'package:farmer_club/data/firebase_services/fire_auth.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/shared_widgets/snack_bar.dart';
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

  bool isLoading = false;
  void _isLoading(bool loadingState) {
    isLoading = loadingState;
    notifyListeners();
  }
}
