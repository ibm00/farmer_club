import 'package:farmer_club/screens/home_screen/components/edit_post_provider.dart';
import 'package:farmer_club/utils/shared_widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/providers/user_data_provider.dart';
import '../../../utils/constants/styles.dart';
import '../../../utils/shared_widgets/button_widget.dart';
import '../../../utils/shared_widgets/image_avatar_widget.dart';
import '../../../utils/shared_widgets/snack_bar.dart';

class EditPostScreen extends ConsumerWidget {
  final Map dataMap;
  const EditPostScreen(this.dataMap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editPostProv = ref.read(editPostProvider(dataMap));
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const AppBarWidget(title: "تعديل البوست"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Stack(
                  fit: StackFit.loose,
                  children: [
                    TextFormField(
                      controller: editPostProv.postTextController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        contentPadding: EdgeInsetsDirectional.only(
                          start: 46,
                          bottom: 8.0,
                          top: 8.0,
                        ),
                        hintText: "ما الذي يدور في رأسك؟",
                      ),
                    ),
                    Positioned(
                      top: 1,
                      child: ImageAvatarWidget(
                        imageUrl: ref.read(userDataProvider).imageUrl,
                      ),
                    ),
                  ],
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final ImageProvider? userImage = ref.watch(
                      editPostProvider(dataMap)
                          .select((value) => value.userImage),
                    );
                    return (editPostProv.imageUrl == "" && userImage == null)
                        ? const SizedBox()
                        : Image(
                            image: userImage ??
                                NetworkImage(
                                  editPostProv.imageUrl,
                                ),
                          );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      elevation: 4,
                      borderRadius: 10,
                      color: const Color(0xffF8F9FB),
                      title: 'صورة',
                      onButtonPressed: () {
                        editPostProv.pickImage(context);
                      },
                      textColor: kGeryPurpleColor,
                      icon: const Icon(
                        Icons.camera_alt,
                        color: kGreenIconsColor,
                      ),
                    ),
                    const Spacer(),
                    ButtonWidget(
                      elevation: 4,
                      borderRadius: 10,
                      color: kPrimaryTextColor,
                      title: 'حفظ',
                      onButtonPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        editPostProv.editPost(context);
                        Navigator.of(context).pop();
                        showMySnakebar(
                          context,
                          "تم حفظ البوست بنجاح",
                        );
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
