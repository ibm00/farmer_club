import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:farmer_club/screens/profile_screen/profile_provider.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:farmer_club/utils/shared_widgets/circular_loading_widget.dart';
import 'package:farmer_club/utils/shared_widgets/image_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/user_model.dart';
import '../home_screen/home_provider.dart';
import 'components/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile-screen";
  final bool isMyProfile;
  final String userId;

  const ProfileScreen({
    Key? key,
    required this.userId,
    required this.isMyProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          ref.read(addingPostProvider).clearPostDialog();
          return Future.value(false);
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: SvgPicture.asset(
                      "assets/images/splash_flower.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 198),
                    child: Consumer(builder: (context, ref, _) {
                      if (isMyProfile) {
                        final userData = ref.read(userDataProvider);
                        return EntireContent(
                          userProv: userData,
                          isMyProfile: isMyProfile,
                        );
                      } else {
                        final otherUserProv =
                            ref.watch(getOtherUserDataProvider(userId));
                        return otherUserProv.when(
                          data: (userData) {
                            userData!.userId = userId;
                            return EntireContent(
                              userProv: userData,
                              isMyProfile: isMyProfile,
                            );
                          },
                          loading: () => const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: CircularLoadingWidget(),
                          ),
                          error: (e, s) => Text(e.toString()),
                        );
                      }
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class EntireContent extends StatelessWidget {
  final UserModel userProv;
  final bool isMyProfile;
  const EntireContent({
    Key? key,
    required this.userProv,
    required this.isMyProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: ProfileBody(userProv, isMyProfile: isMyProfile),
          ),
          const Positioned(
            top: -80,
            child: ImageAvatarWidget(
              radius: 125 / 2,
              borderThikness: 6,
              imageUrl:
                  "https://www.naso.org/wp-content/uploads/2016/12/person-pointing.jpg",
            ),
          ),
        ],
      ),
    );
  }
}
