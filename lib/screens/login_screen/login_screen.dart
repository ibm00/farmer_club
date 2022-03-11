import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/styles.dart';
import '../../utils/shared_widgets/top_loading_widget.dart';
import '../register_screen/register_screen.dart';
import 'components/login_form.dart';
import 'login_screen_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login-screen';
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(builder: (context, ref, _) {
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 50),
                  SvgPicture.asset(
                    'assets/images/login_photo.svg',
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'أهلا بك في\nFarmer Club',
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
                      const Text('ليس لديك حساب؟ ', style: kTextStyleReg13),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RegisterScreen.routeName);
                        },
                        child: const Text('إنشاء حساب جديد',
                            style: kTextStyleGreenReg13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
              if (ref.watch(loginProvider).isLoading) const TopLoadingWidget()
            ],
          );
        }),
      ),
    );
  }
}
