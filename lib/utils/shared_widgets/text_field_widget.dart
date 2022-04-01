import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    this.validator,
    this.hintText,
    this.onSaving,
    this.onChange,
    this.controller,
    this.prefix,
    this.isContentPadding = true,
    this.isLongField = false,
  });
  final Function(String?)? validator;
  final Function(String?)? onSaving;
  final Function(String?)? onChange;
  final String? hintText;
  final TextEditingController? controller;
  final bool isLongField;
  final Widget? prefix;
  final bool isContentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      controller: controller,
      validator: (v) => validator == null ? null : validator!(v),
      maxLines: isLongField ? 4 : 1,
      onSaved: (v) => onSaving == null ? null : onSaving!(v),
      decoration: InputDecoration(
        prefixIconColor: Colors.black,
        prefixIcon: prefix,
        filled: true,
        fillColor: Colors.grey[100],
        border: InputBorder.none,
        contentPadding: isContentPadding
            ? const EdgeInsetsDirectional.only(
                start: 14.0,
                bottom: 8.0,
                top: 8.0,
              )
            : const EdgeInsets.all(0),
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
    gapPadding: 0);
