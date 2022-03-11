import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    this.validator,
    this.hintText,
    this.onSaving,
    this.controller,
    this.isLongField = false,
  });
  final Function(String?)? validator;
  final Function(String?)? onSaving;
  final String? hintText;
  final TextEditingController? controller;
  final bool isLongField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) => validator == null ? null : validator!(v),
      maxLines: isLongField ? 4 : 1,
      onSaved: (v) => onSaving == null ? null : onSaving!(v),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: InputBorder.none,
        contentPadding: const EdgeInsetsDirectional.only(
          start: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
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
