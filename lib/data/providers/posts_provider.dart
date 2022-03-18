import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../firebase_services/fire_home.dart';
import '../models/post_model.dart';

final postsProvider = StreamProvider.family<List<Post>, String?>(
  (ref, userId) {
    // print("دخل");
    return FireHome.getHomePosts().map(
      (postsCollectionSnapshot) => postsCollectionSnapshot.docs
          .map(
            (postsDocSnapshot) => Post.fromJson(postsDocSnapshot.data()),
          )
          .toList()
          .where(
        (post) {
          // print("userIddddddddddddddddddddddddd");
          // print(userId);
          if (userId != null) {
            // print("in");
            return post.userId == userId;
          } else {
            return true;
          }
        },
      ).toList(),
    );
  },
);
