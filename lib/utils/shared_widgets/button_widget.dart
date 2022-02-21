import '../../utils/constants/styles.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onButtonPressed;
  final Color color;
  final Color textColor;
  final TextStyle textStyle;
  final double borderRadius;
  final double width;
  final double hight;
  final double elevation;
  final Widget? icon;
  const ButtonWidget({
    required this.title,
    required this.onButtonPressed,
    this.color = kPrimaryColor,
    this.borderRadius = 35.0,
    this.width = double.infinity,
    this.hight = 46,
    this.elevation = 2,
    this.textStyle = kTextStyleWhiteBold18,
    this.textColor = Colors.white,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon ?? Container(),
      label: Text(title),
      onPressed: onButtonPressed,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        primary: color,
        onPrimary: textColor,
        elevation: 2,
        textStyle: textStyle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: Size(width, hight),
      ),
    );
  }
}
