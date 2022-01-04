import 'package:farmer_club/presentation/screens/login_screen/components/login_form.dart';
import 'package:farmer_club/presentation/screens/register_screen/register_screen.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login-screen';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            SvgPicture.asset(
              'assets/images/login_photo.svg',
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to Farmer\nClub',
              style: kTextStyleReg24,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: LoginForm(),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? ', style: kTextStyleReg13),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child:
                      const Text('Register now', style: kTextStyleGreenReg13),
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
