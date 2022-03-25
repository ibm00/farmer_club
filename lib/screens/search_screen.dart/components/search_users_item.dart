import 'package:farmer_club/data/models/user_model.dart';
import 'package:farmer_club/screens/search_screen.dart/search_provider.dart';
import 'package:farmer_club/utils/constants/styles.dart';
import 'package:farmer_club/utils/shared_widgets/button_widget.dart';
import 'package:farmer_club/utils/shared_widgets/image_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/user_data_provider.dart';
import '../../../utils/shared_widgets/follow_button.dart';
import '../../profile_screen/profile_screen.dart';

class SearchUsersItem extends ConsumerWidget {
  final UserModel userModel;
  const SearchUsersItem({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProfileScreen.routeName,
          arguments: {
            "isMyProfile":
                ref.watch(userDataProvider).userId == userModel.userId,
            "userId": userModel.userId,
          },
        );
      },
      leading: ImageAvatarWidget(imageUrl: userModel.imageUrl),
      title: Text(userModel.name!),
      subtitle: const Text("لم نخلق عبثا"),
      trailing: ref.watch(userDataProvider).userId == userModel.userId
          ? null
          : FollowButton(
              isInsideProfile: false,
              isFollow: userModel.isCurrentUserFollowThisUser,
              otherUserID: userModel.userId!,
            ),
    );
  }
}
