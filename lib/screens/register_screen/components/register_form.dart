import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/helpers/validators.dart';
import '../../../utils/shared_widgets/button_widget.dart';
import '../../../utils/shared_widgets/icons_wrapper.dart';
import '../../../utils/shared_widgets/text_field_widget.dart';
import '../register_provider.dart';

class RegisterForm extends ConsumerWidget {
  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerProv = ref.watch(registerProvider);
    return Form(
      key: registerProv.formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const IconWrapper(Icons.person_outline_rounded),
              const SizedBox(width: 6),
              Expanded(
                child: TextFieldWidget(
                  hintText: 'Name',
                  onSaving: (v) {
                    registerProv.setName = v!;
                  },
                  validator: (v) =>
                      ValidatorsHelper.isEmptyValidator(v!.trim()),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const IconWrapper(Icons.email_outlined),
              const SizedBox(width: 6),
              Expanded(
                child: TextFieldWidget(
                  hintText: 'Email',
                  onSaving: (v) {
                    registerProv.setEmail = v!;
                  },
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
                  controller: registerProv.passController,
                  hintText: 'Password',
                  onSaving: (v) {
                    registerProv.setPassword = v!;
                  },
                  validator: (v) =>
                      ValidatorsHelper.passwordValidator(v!.trim()),
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
                  hintText: 'Retype Password',
                  onSaving: (v) {},
                  validator: (v) => ValidatorsHelper.rePasswordValidator(
                    v!,
                    registerProv.passController.text,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          ButtonWidget(
            onButtonPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              registerProv.onRegisterPressed(context);
            },
            title: 'Rigester',
          )
        ],
      ),
    );
  }
}
