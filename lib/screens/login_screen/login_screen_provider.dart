import 'package:farmer_club/data/firebase_services/fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/shared_widgets/snack_bar.dart';
import '../home_screen/home_screen.dart';

final loginProvider = ChangeNotifierProvider.autoDispose<LoginScreenProvider>(
  (ref) => LoginScreenProvider(),
);

class LoginScreenProvider extends ChangeNotifier {
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
      await FireAuth.signin(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
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
