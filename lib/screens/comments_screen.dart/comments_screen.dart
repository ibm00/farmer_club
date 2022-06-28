import 'package:farmer_club/screens/comments_screen.dart/comments_provider.dart';
import 'package:farmer_club/utils/shared_widgets/app_bar_widget.dart';
import 'package:farmer_club/utils/shared_widgets/circular_loading_widget.dart';
import 'package:farmer_club/utils/shared_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/comment_widget.dart';

class CommentsScreen extends StatefulWidget {
  static const routeName = "/comment-screen";
  final String postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  // FocusNode focusNode = FocusNode();
  // @override
  // void dispose() {
  //   super.dispose();
  //   focusNode.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'التعليقات'),
      body: Consumer(
        builder: (context, ref, child) {
          final commentProv = ref.watch(getCommentsProvider(widget.postId));
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
          final addingCommentProv =
              ref.read(addingCommentProvider(widget.postId));
          return Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom + 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    // focusNode: focusNode,
                    controller: addingCommentProv.commentController,
                    hintText: "أكتب تعليقك هنا...",
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await addingCommentProv.addNewComment(context);
                  },
                  child: const Icon(Icons.send),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
