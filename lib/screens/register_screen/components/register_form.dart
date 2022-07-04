import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/helpers/validators.dart';
import '../../../utils/constants/styles.dart';
import '../../../utils/helpers/image_link_helper.dart';
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
          const SizedBox(height: 50),
          Consumer(builder: (context, ref, _) {
            final ImageProvider? userImage = ref.watch(
              registerProvider.select((value) => value.userImage),
            );
            return CircleAvatar(
              radius: 50,
              backgroundColor: const Color.fromARGB(145, 238, 62, 8),
              backgroundImage: userImage ??
                  const AssetImage("assets/images/default-profile-pic.jpg"),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    ref.read(registerProvider).pickImage(context);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: kBackgroundColor,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 30),
          Row(
            children: [
              const IconWrapper(Icons.person_outline_rounded),
              const SizedBox(width: 6),
              Expanded(
                child: TextFieldWidget(
                  hintText: 'الاسم',
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
                  hintText: 'البريد الإلكتروني',
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
                  hintText: 'كلمة المرور',
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
                  hintText: 'أعد كتابة كلمة المرور',
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
            width: double.infinity,
            onButtonPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              registerProv.onRegisterPressed(context);
            },
            title: 'تسجيل',
          )
        ],
      ),
    );
  }
}
