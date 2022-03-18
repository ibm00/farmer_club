import 'package:farmer_club/screens/profile_screen/profile_provider.dart';
import 'package:farmer_club/utils/shared_widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user_model.dart';
import '../../../utils/constants/styles.dart';
import '../../../utils/shared_widgets/add_post_card.dart';
import '../../../utils/shared_widgets/circular_loading_widget.dart';
import '../../../utils/shared_widgets/post_box_widget.dart';
import '../../home_screen/home_provider.dart';
import 'user_numbers.dart';

class ProfileBody extends StatelessWidget {
  final UserModel userProv;
  final bool isMyProfile;

  const ProfileBody(
    this.userProv, {
    Key? key,
    required this.isMyProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 65),
        Text(
          userProv.name!,
          style: kTextStyleProfileName25,
        ),
        const SizedBox(height: 30),
        UserNumber(
          followersNum: userProv.followersNum,
          followingsNum: userProv.followingsNum,
          postsNum: userProv.postsNum,
        ),
        const SizedBox(height: 20),
        isMyProfile
            ? const AddPostCard()
            : ButtonWidget(
                title: "متابعة",
                onButtonPressed: () {},
                icon: const Icon(Icons.add),
              ),
        const SizedBox(height: 20),
        Consumer(
          builder: (context, ref, _) {
            final postsProv = ref.watch(profilePostsProvider(userProv.userId));

            return postsProv.when(
              data: (posts) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) => PostBoxWidget(
                    posts[index],
                    deletePostFun: ref.read(addingPostProvider).deletePost,
                  ),
                );
              },
              error: (e, s) => Text("error Happend: ${e.toString()}"),
              loading: () => const CircularLoadingWidget(),
            );
          },
        ),
      ],
    );
  }
}
