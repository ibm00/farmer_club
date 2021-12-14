import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';

class IconWrapper extends StatelessWidget {
  const IconWrapper(this.prefixIcon);
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      child: Icon(
        prefixIcon,
        size: 25,
        color: kGreenIconsColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[100],
      ),
    );
  }
}
