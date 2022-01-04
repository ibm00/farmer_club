import 'package:farmer_club/presentation/shared_widgets/button_widget.dart';
import 'package:farmer_club/presentation/shared_widgets/icons_wrapper.dart';
import 'package:farmer_club/presentation/shared_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              const IconWrapper(Icons.email_outlined),
              const SizedBox(width: 6),
              Expanded(
                child: TextFieldWidget(
                  hintText: 'Email',
                  onSaving: (v) {},
                  validator: (v) {},
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
                  hintText: 'Password',
                  onSaving: (v) {},
                  validator: (v) {},
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          ButtonWidget(
            onButtonPressed: () {},
            title: 'Login',
          )
        ],
      ),
    );
  }
}
