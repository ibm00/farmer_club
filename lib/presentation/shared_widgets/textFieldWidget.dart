import 'package:farmer_club/constants/styles.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.validator,
    required this.onSaving,
  });
  final String? Function(String?) validator;
  final String? Function(String?) onSaving;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) => validator(v),
      onSaved: (v) => onSaving(v),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        hintText: 'Name',
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
