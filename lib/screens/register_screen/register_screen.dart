import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/styles.dart';
import '../../utils/shared_widgets/top_loading_widget.dart';
import '../login_screen/login_screen.dart';
import 'components/register_form.dart';
import 'register_provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(builder: (context, ref, _) {
          final registerProv = ref.watch(registerProvider);
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    child: SvgPicture.asset(
                      'assets/images/register_photo.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'أنضم الآن إلى مجتمعنا',
                    style: kTextStyleReg24.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: RegisterForm(),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'لديك حساب بالفعل؟ ',
                        style: kTextStyleReg13,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                        child: const Text(
                          'تسجيل الدخول',
                          style: kTextStyleGreenReg13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
              if (registerProv.isLoading) const TopLoadingWidget(),
            ],
          );
        }),
      ),
    );
  }
}
