import 'package:farmer_club/utils/constants/styles.dart';

import '../../data/models/post_model.dart';
import 'image_avatar_widget.dart';
import 'package:flutter/material.dart';

class PostBoxWidget extends StatelessWidget {
  final Post _post;

  const PostBoxWidget(this._post);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 22),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageAvatarWidget(
                  imageUrl: _post.userImgUrl,
                  // borderThikness: 2,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_post.userName, style: kTextStylePostName16),
                    const SizedBox(height: 2),
                    Text(_post.postDate, style: kTextStylePostDate12),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  onTapDown: (details) => showPopupMenu(context, details),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            if (_post.postText != "") const SizedBox(height: 15),
            if (_post.postText != "")
              Text(
                _post.postText,
                style: kTextStylePost13,
              ),
            const SizedBox(height: 10),
            if (_post.userImgUrl != "")
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(35),
                ),
                child: Image.network(_post.userImgUrl),
              ),
            const SizedBox(height: 15),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      //TODO: Navigate To Comments Screen
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_post.commentsNum.toString(),
                            style: kTextStyleComNum12),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.mode_comment_outlined,
                          size: 18,
                          color: kGeryPurpleColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showPopupMenu(BuildContext context, TapDownDetails details) {
    showMenu<int>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: _post.isMyPost
          ? const [
              PopupMenuItem<int>(child: Text('Edit'), value: 1),
              PopupMenuItem<int>(child: Text('Delete'), value: 2),
            ]
          : const [
              PopupMenuItem<int>(child: Text('Save Post'), value: 1),
              PopupMenuItem<int>(child: Text('Report Post'), value: 2),
            ],
      elevation: 10.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;
      if (_post.isMyPost) {
        switch (itemSelected) {
          case 1:
            {
              //Edit Function
            }
            break;

          case 2:
            {
              //Delelte Function
            }
            break;
        }
      } else {
        switch (itemSelected) {
          case 1:
            {
              //Save Post Function
            }
            break;

          case 2:
            {
              //Report Post Function
            }
            break;
        }
      }
    });
  }
}