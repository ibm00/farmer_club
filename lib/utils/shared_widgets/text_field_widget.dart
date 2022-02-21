import '../../constants/styles.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.validator,
    required this.hintText,
    this.onSaving,
    this.controller,
  });
  final Function(String?) validator;
  final Function(String?)? onSaving;
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) => validator(v),
      onSaved: (v) => onSaving == null ? null : onSaving!(v),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        hintText: hintText,
        hintStyle: kTextStyleGerybold16,
        focusedBorder: _outlineBorder,
        enabledBorder: _outlineBorder,
        errorBorder: _outlineBorder,
        focusedErrorBorder: _outlineBorder,
      ),
    );
  }
}

final _outlineBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey[100]!),
  borderRadius: BorderRadius.circular(15),
);
