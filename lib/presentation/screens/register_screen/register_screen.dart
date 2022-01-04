import 'package:farmer_club/presentation/screens/login_screen/login.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = '/register-screen';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/images/register_photo.svg',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Let\'s Join Our Community', style: kTextStyleReg24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: RegisterForm(),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: kTextStyleReg13,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: const Text('Login now', style: kTextStyleGreenReg13),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
