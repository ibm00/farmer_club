import 'package:farmer_club/data/firebase_services/fire_search.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../firebase_services/fire_home.dart';
import '../models/post_model.dart';

final postsProvider = StreamProvider.family<List<Post>, String?>(
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
            final followingUserProv = ref.watch(followingUsersProvider);
            final List<String> followingList = followingUserProv.value!;
            followingList.add(ref.watch(userDataProvider).userId!);
            return followingList.contains(post.userId);
          }
        },
      ).toList(),
    );
  },
);

final followingUsersProvider = StreamProvider<List<String>>(
  (ref) => FireSearch.getFollowingUsers(
    ref.watch(userDataProvider).userId!,
  ).map(
    (event) => event.docs.map((e) => e.id).toList(),
  ),
);
