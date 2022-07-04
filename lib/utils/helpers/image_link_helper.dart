import 'package:flutter/material.dart';

ImageProvider networkImageHelper({
  required String imageLink,
  required String defaultImagePath,
}) {
  if (imageLink.isNotEmpty) {
    return NetworkImage(imageLink);
  } else {
    return AssetImage(defaultImagePath);
  }
}
