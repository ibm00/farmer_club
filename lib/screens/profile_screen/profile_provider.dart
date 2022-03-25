import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/firebase_services/fire_home.dart';
import '../../data/firebase_services/fire_profile.dart';
import '../../data/models/post_model.dart';
import '../../data/models/user_model.dart';

final getOtherUserDataProvider =
    FutureProvider.autoDispose.family<UserModel?, String>(
  (ref, userId) => FireProfile.getOtherUserData(
    userId,
    ref.read(userDataProvider).userId!,
  ),
);

final profilePostsProvider =
    StreamProvider.autoDispose.family<List<Post>, String?>(
  (ref, userId) {
    return FireHome.getHomePosts().map(
      (postsCollectionSnapshot) => postsCollectionSnapshot.docs
          .map(
            (postsDocSnapshot) => Post.fromJson(postsDocSnapshot.data()),
          )
          .toList()
          .where(
        (post) {
          if (userId != null) {
            return post.userId == userId;
          } else {
            return true;
          }
        },
      ).toList(),
    );
  },
);
