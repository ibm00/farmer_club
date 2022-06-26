import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:farmer_club/screens/home_screen/home_provider.dart';
import 'package:farmer_club/utils/shared_widgets/button_widget.dart';
import 'package:farmer_club/utils/shared_widgets/image_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/styles.dart';
import 'circular_loading_widget.dart';

class AddPostCard extends ConsumerWidget {
  // final String imgUrl;
  const AddPostCard({Key? key}) : super(key: key);

  get kTextStyleGerybold16 => null;

  get kTextStylebold16 => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addPostProv = ref.read(addingPostProvider);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Stack(
              fit: StackFit.loose,
              children: [
                TextFormField(
                  controller: addPostProv.homePostController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsetsDirectional.only(
                      start: 46,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    hintText: "ما الذي يدور في رأسك؟",
                    hintStyle: kTextStylebold16,
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
            Consumer(builder: (context, ref, _) {
              final ImageProvider? userImage = ref.watch(
                addingPostProvider.select((value) => value.userImage),
              );
              return userImage != null
                  ? Image(image: userImage)
                  : const SizedBox();
            }),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWidget(
                  elevation: 4,
                  borderRadius: 10,
                  color: const Color(0xffF8F9FB),
                  title: 'صورة',
                  onButtonPressed: () {
                    addPostProv.pickImage(context);
                    // print(ref.read(userDataProvider).email);
                    // print(ref.read(userDataProvider).name);
                    // print(ref.read(userDataProvider).userId);
                    //Todo: add photo cycle
                    // FireAuth.signout(context);
                  },
                  textColor: kGeryPurpleColor,
                  icon: const Icon(
                    Icons.camera_alt,
                    color: kGreenIconsColor,
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final bool isPostLoading = ref.watch(
                      addingPostProvider
                          .select((value) => value.isLoadingNewPost),
                    );
                    return isPostLoading
                        ? Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: const CircularLoadingWidget(),
                          )
                        : ButtonWidget(
                            elevation: 4,
                            borderRadius: 10,
                            color: kPrimaryTextColor,
                            title: 'نشر',
                            onButtonPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              await addPostProv.addNewPost(context);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// final _outlineBorder = OutlineInputBorder(
//   borderSide: BorderSide(
//     color: Colors.grey[100]!,
//   ),
//   borderRadius: BorderRadius.circular(15),
// );
