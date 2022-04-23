import 'package:easy_localization/easy_localization.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'select_photo_widget.dart';

class SelectPhotoOptionsWidget extends StatelessWidget {
  const SelectPhotoOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "أخذ صورة بواسطة",
              style: kTextStyleReg13.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SelectPhotoWidget(
                  mIconData: Icons.camera_alt,
                  title: "الكاميرا",
                  mOnTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
                SelectPhotoWidget(
                  title: "الوسائط",
                  mIconData: Icons.photo,
                  mOnTap: () => Navigator.of(context).pop(ImageSource.gallery),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
