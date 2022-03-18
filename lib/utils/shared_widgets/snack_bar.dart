import 'package:flutter/material.dart';

showMySnakebar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black54,
      width: MediaQuery.of(context).size.width * .7,
      content: Text(message, textAlign: TextAlign.center),
      duration: const Duration(seconds: 1),
    ),
  );
}
