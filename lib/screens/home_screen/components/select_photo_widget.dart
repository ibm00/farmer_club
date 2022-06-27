import 'package:flutter/material.dart';

import '../../../../utils/constants/styles.dart';

class SelectPhotoWidget extends StatelessWidget {
  const SelectPhotoWidget({
    Key? key,
    required this.title,
    required this.mIconData,
    required this.mOnTap,
  }) : super(key: key);

  final String title;
  final IconData mIconData;
  final void Function()? mOnTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: mOnTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              mIconData,
              color: kPrimaryColor,
              size: 50,
            ),
            Text(title, style: kTextStyleReg13),
          ],
        ),
      ),
    );
  }
}
