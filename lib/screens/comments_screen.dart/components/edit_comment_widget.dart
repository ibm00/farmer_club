import 'package:farmer_club/data/models/comment_model.dart';
import 'package:farmer_club/screens/comments_screen.dart/comments_provider.dart';
import 'package:farmer_club/utils/shared_widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/shared_widgets/snack_bar.dart';
import '../../../utils/shared_widgets/text_field_widget.dart';

class EditCommentWidget extends StatefulWidget {
  final Comment comment;
  const EditCommentWidget(this.comment, {Key? key}) : super(key: key);

  @override
  State<EditCommentWidget> createState() => _EditCommentWidgetState();
}

class _EditCommentWidgetState extends State<EditCommentWidget> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller.text = widget.comment.commentText!;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 60,
          top: 10,
        ),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFieldWidget(
                validator: ((p0) {
                  if (p0!.trim().isEmpty) {
                    return "لا يمكن نشر تعليق فارغ";
                  } else {
                    return null;
                  }
                }),
                controller: controller,
                hintText: "أكتب تعليقك هنا...",
              ),
            ),
            const SizedBox(height: 30),
            Consumer(builder: (context, ref, _) {
              return ButtonWidget(
                title: "حفظ",
                onButtonPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  widget.comment.commentText = controller.text;
                  ref
                      .read(addingCommentProvider(widget.comment.postId!))
                      .updateComment(widget.comment);
                  Navigator.of(context).pop();
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
