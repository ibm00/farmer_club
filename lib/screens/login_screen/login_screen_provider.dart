import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_club/data/firebase_services/fire_auth.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/shared_widgets/snack_bar.dart';
import '../home_screen/home_screen.dart';

final loginProvider = ChangeNotifierProvider.autoDispose<LoginScreenProvider>(
    (ref) => LoginScreenProvider(ref.read));

class LoginScreenProvider extends ChangeNotifier {
  final Reader reader;
  LoginScreenProvider(this.reader);
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> onLoginPressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final isRegisterSuccess = await _login(context);
      if (isRegisterSuccess) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    }
  }

  Future<bool> _login(BuildContext context) async {
    _isLoading(true);
    try {
      final userId = await FireAuth.signin(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (userId != null) {
        final userDateSnapshot =
            await FirebaseFirestore.instance.doc("users/$userId").get();
        final userData = userDateSnapshot.data();
        if (userData != null) {
          reader(userDataProvider).email = emailController.text.trim();
          reader(userDataProvider).name = userData['name'];
          reader(userDataProvider).imageUrl = userData['imageUrl'];
          reader(userDataProvider).userId = userId;
        }
      }
      _isLoading(false);
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
