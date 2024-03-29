import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_club/screens/comments_screen.dart/comments_screen.dart';
import 'package:farmer_club/screens/home_screen/components/edit_post_screen.dart';
import 'package:farmer_club/screens/profile_screen/profile_screen.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/post_model.dart';
import '../../data/providers/user_data_provider.dart';
import 'image_avatar_widget.dart';
import 'package:flutter/material.dart';

class PostBoxWidget extends StatelessWidget {
  final Post _post;
  final void Function(BuildContext, String)? deletePostFun;

  const PostBoxWidget(this._post, {this.deletePostFun});
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(builder: (context, ref, _) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ProfileScreen.routeName,
                        arguments: {
                          "isMyProfile": ref.watch(userDataProvider).userId ==
                              _post.userId,
                          "userId": _post.userId,
                        },
                      );
                    },
                    child: ImageAvatarWidget(
                      imageUrl: _post.userImgUrl ?? "",
                      // borderThikness: 2,
                    ),
                  );
                }),
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
                // if (_post.isMyPost)
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
            if (_post.postText != "")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    _post.postText,
                    style: kTextStylePost13,
                  ),
                ],
              ),
            const SizedBox(height: 10),
            if (_post.postImage != null && _post.postImage != "")
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(35),
                ),
                child: CachedNetworkImage(imageUrl: _post.postImage ?? ""),
              ),
            const SizedBox(height: 15),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        CommentsScreen.routeName,
                        arguments: _post.postId,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _post.commentsNum.toString(),
                          style: kTextStyleComNum12,
                        ),
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
        details.globalPosition.dy,
        details.globalPosition.dx,
      ),
      items: _post.isMyPost
          ? const [
              PopupMenuItem<int>(child: Text('تعديل'), value: 1),
              PopupMenuItem<int>(child: Text('مسح'), value: 2),
            ]
          : const [
              PopupMenuItem<int>(child: Text('الإبلاغ عن المنشور'), value: 1),
              PopupMenuItem<int>(
                  child: Text('الإبلاغ عن صاحب المنشور'), value: 2),
              PopupMenuItem<int>(child: Text('حظر صاحب المنشور'), value: 4),
            ],
      elevation: 10.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;
      if (_post.isMyPost) {
        switch (itemSelected) {
          case 1:
            {
              //Edit Function
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditPostScreen(
                    {
                      "postId": _post.postId,
                      "postText": _post.postText,
                      "imageUrl": _post.postImage,
                    },
                  ),
                ),
              );
            }
            break;

          case 2:
            {
              //Delelte Function
              deletePostFun!(context, _post.postId!);
            }
            break;
        }
      } else {
        switch (itemSelected) {
          case 1:
            {
              //report Post Function
            }
            break;

          case 2:
            {
              //Report Post owner
            }
            break;
          case 3:
            {
              //block Post owner
            }
            break;
        }
      }
    });
  }
}
