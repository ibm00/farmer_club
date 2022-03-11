import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';

class ImageAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double borderThikness;
  final Color borderColor;

  const ImageAvatarWidget({
    required this.imageUrl,
    this.radius = 20,
    this.borderThikness = 0.0,
    this.borderColor = const Color(0xff6FE139),
  });
  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return ClipRRect(
      child: CachedNetworkImage(
        // color: kPrimaryColor,
        // useOldImageOnUrlChange: true,
        width: radius * 2,
        height: radius * 2,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => Icon(
          Icons.account_circle_outlined,
          color: kPrimaryColor,
          size: radius * 2,
        ),
      ),
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
