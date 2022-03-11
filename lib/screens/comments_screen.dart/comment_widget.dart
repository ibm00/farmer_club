import 'package:farmer_club/utils/constants/styles.dart';
import 'package:farmer_club/utils/shared_widgets/image_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'comments_provider.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageAvatarWidget(imageUrl: comment.userImage!),
      title: Row(
        children: [
          Text(
            comment.userName!,
            style: kTextStylePostName16,
          ),
          const SizedBox(width: 1),
          Container(
            width: 1,
            height: 1,
            decoration: const BoxDecoration(
              color: Color(0xff484D54),
              shape: BoxShape.circle,
              //  border: Border.all(width: 1, color:const Color(0xff484D54))
            ),
          ),
          Text(
            timeago.format(comment.commentDate!, locale: 'ar'),
            style: kTextStyleRegGery13,
          )
        ],
      ),
      subtitle: Text(comment.commentText!),
      trailing: comment.isMyComment
          ? Consumer(builder: (context, ref, _) {
              return InkWell(
                  onTap: () async {
                    print("delete start");
                    await ref
                        .read(addingCommentProvider(comment.postId!))
                        .deleteComment(context, comment);
                    print("delete done");
                  },
                  child: const Icon(Icons.delete));
            })
          : null,
    );
  }
}
