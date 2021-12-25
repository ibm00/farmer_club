import '../../../utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/app_logo.dart';
import 'components/app_name.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          AppLogo(),
          const SizedBox(height: 10),
          const AppName(),
        ],
      ),
      bottomNavigationBar: SvgPicture.asset('assets/images/splash_flower.svg'),
    );
  }
}
