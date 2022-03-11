import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/helpers/validators.dart';
import '../../../utils/shared_widgets/button_widget.dart';
import '../../../utils/shared_widgets/icons_wrapper.dart';
import '../../../utils/shared_widgets/text_field_widget.dart';
import '../login_screen_provider.dart';

class LoginForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loginProv = ref.read(loginProvider);
    return Form(
      key: _loginProv.formKey,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              const IconWrapper(Icons.email_outlined),
              const SizedBox(width: 6),
              Expanded(
                child: TextFieldWidget(
                  controller: _loginProv.emailController,
                  hintText: 'البريد الإلكتروني',
                  validator: (v) => ValidatorsHelper.emailValidator(v!.trim()),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const IconWrapper(Icons.lock_outline),
              const SizedBox(width: 6),
              Expanded(
                child: TextFieldWidget(
                  controller: _loginProv.passwordController,
                  hintText: 'كلمة المرور',
                  validator: (v) =>
                      ValidatorsHelper.passwordValidator(v!.trim()),
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          ButtonWidget(
            width: double.infinity,
            onButtonPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _loginProv.onLoginPressed(context);
            },
            title: 'تسجيل الدخول',
          )
        ],
      ),
    );
  }
}
