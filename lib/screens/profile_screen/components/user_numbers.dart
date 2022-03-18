import 'package:flutter/material.dart';

import '../../../utils/constants/styles.dart';

class UserNumber extends StatelessWidget {
  final int postsNum;
  final int followersNum;
  final int followingsNum;
  const UserNumber({
    Key? key,
    required this.followersNum,
    required this.followingsNum,
    required this.postsNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "المنشورات",
              style: kTextStyleReg18.copyWith(color: kPrimaryColor),
            ),
            Text(postsNum.toString()),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 22,
          width: .5,
          color: const Color(0xff707070).withOpacity(.5),
        ),
        Column(
          children: [
            Text(
              "المتابعون",
              style: kTextStyleReg18.copyWith(color: kPrimaryColor),
            ),
            Text(followersNum.toString()),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 22,
          width: .5,
          color: const Color(0xff707070).withOpacity(.5),
        ),
        Column(
          children: [
            Text(
              "يتابع",
              style: kTextStyleReg18.copyWith(color: kPrimaryColor),
            ),
            Text(followingsNum.toString()),
          ],
        ),
      ],
    );
  }
}
