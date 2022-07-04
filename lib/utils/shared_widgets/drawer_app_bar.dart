import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/user_data_provider.dart';
import '../../screens/profile_screen/profile_screen.dart';
import 'image_avatar_widget.dart';

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
          ),
        ),
        height: 150,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: kBackgroundColor,
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        ProfileScreen.routeName,
                        arguments: {
                          "isMyProfile": true,
                          "userId": ref.watch(userDataProvider).userId,
                        },
                      );
                    },
                    child: Row(
                      children: [
                        ImageAvatarWidget(
                          radius: 30,
                          borderThikness: 2,
                          borderColor: kBackgroundColor,
                          imageUrl: ref.read(userDataProvider).imageUrl,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ref.read(userDataProvider).name ?? "",
                                style: kTextStyleWhiteBold18,
                              ),
                              Text(
                                ref.read(userDataProvider).email ?? "",
                                style: kTextStyleRegGery13.copyWith(
                                  color: kLightPrimaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
