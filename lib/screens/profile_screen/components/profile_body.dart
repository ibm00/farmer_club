import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:farmer_club/screens/profile_screen/profile_provider.dart';
import 'package:farmer_club/utils/shared_widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_model.dart';
import '../../../utils/constants/styles.dart';
import '../../../utils/shared_widgets/add_post_card.dart';
import '../../../utils/shared_widgets/circular_loading_widget.dart';
import '../../../utils/shared_widgets/post_box_widget.dart';
import '../../home_screen/home_provider.dart';
import 'user_numbers.dart';

class ProfileBody extends ConsumerStatefulWidget {
  final UserModel userProv;
  final bool isMyProfile;

  const ProfileBody(
    this.userProv, {
    Key? key,
    required this.isMyProfile,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends ConsumerState<ProfileBody> {
  int? followers;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(addingPostProvider).clearPostDialog();
    });
    followers = widget.userProv.followersNum;
    // Future.delayed(const Duration(seconds: 1)).then(
    //   (value) => ref.read(addingPostProvider).clearPostDialog(),
    // );
    super.initState();
  }

  void updateFolllowersNum(int followers) {
    setState(() {
      this.followers = followers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 65),
        Text(
          widget.userProv.name!,
          style: kTextStyleProfileName25,
        ),
        const SizedBox(height: 30),
        Consumer(
          builder: (context, ref, _) {
            final userProvider = widget.isMyProfile
                ? ref.watch(userDataProvider)
                : widget.userProv;
            return UserNumber(
              followersNum:
                  widget.isMyProfile ? userProvider.followersNum : followers!,
              followingsNum: userProvider.followingsNum,
              postsNum: userProvider.postsNum,
            );
          },
        ),
        const SizedBox(height: 20),
        widget.isMyProfile
            ? const AddPostCard()
            : FollowButton(
                isInsideProfile: true,
                otherUserID: widget.userProv.userId!,
                isFollow: widget.userProv.isCurrentUserFollowThisUser,
                doThisAftherPress: updateFolllowersNum,
              ),
        const SizedBox(height: 20),
        Consumer(
          builder: (context, ref, _) {
            final postsProv =
                ref.watch(profilePostsProvider(widget.userProv.userId));
            return postsProv.when(
              data: (posts) {
                return posts.isEmpty
                    ? const Text(
                        '"هذا الصديق ليس لديه منشورات، تابع أصدقاء جدد"',
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) => PostBoxWidget(
                          posts[index],
                          deletePostFun:
                              ref.read(addingPostProvider).deletePost,
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
