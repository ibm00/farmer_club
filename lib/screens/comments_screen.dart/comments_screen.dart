import 'package:farmer_club/screens/comments_screen.dart/comments_provider.dart';
import 'package:farmer_club/utils/shared_widgets/app_bar_widget.dart';
import 'package:farmer_club/utils/shared_widgets/circular_loading_widget.dart';
import 'package:farmer_club/utils/shared_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'comment_widget.dart';

class CommentsScreen extends StatelessWidget {
  static const routeName = "/comment-screen";
  final String postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'التعليقات'),
      body: Consumer(
        builder: (context, ref, child) {
          final commentProv = ref.watch(getCommentsProvider(postId));
          return commentProv.when(
            data: (comments) => ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) => CommentWidget(
                comments[index],
              ),
            ),
            error: (e, s) => Text(e.toString()),
            loading: () => const CircularLoadingWidget(),
          );
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final addingCommentProv = ref.read(addingCommentProvider(postId));
          return Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                  controller: addingCommentProv.commentController,
                  hintText: "أكتب تعليقك هنا...",
                ),
              ),
              const SizedBox(width: 2),
              InkWell(
                onTap: () {
                  addingCommentProv.addNewComment(context);
                },
                child: const Icon(Icons.send),
              )
            ],
          );
        },
      ),
    );
  }
}
