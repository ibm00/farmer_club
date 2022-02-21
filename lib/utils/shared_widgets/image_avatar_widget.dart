import 'package:flutter/material.dart';

class ImageAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double raduis;
  final double borderThikness;
  final Color borderColor;

  const ImageAvatarWidget({
    required this.imageUrl,
    this.raduis = 20,
    this.borderThikness = 0.0,
    this.borderColor = const Color(0xff6FE139),
  });
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: raduis,
      ),
      radius: raduis + borderThikness,
      backgroundColor: borderColor,
    );
  }
}
