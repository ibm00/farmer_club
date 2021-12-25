import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Align(
        heightFactor: 0.21,
        child: SvgPicture.asset(
          'assets/images/app_large_logo.svg',
        ),
      ),
    );
  }
}
