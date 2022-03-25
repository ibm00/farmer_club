import 'package:farmer_club/data/firebase_services/fire_search.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user_model.dart';

final allUsersProvider = FutureProvider.autoDispose<List<UserModel>?>(
  (ref) async {
    final users =
        await FireSearch.getAllOtherUsers(ref.read(userDataProvider).userId!);
    if (users == null) return null;
    return users;
  },
);

final searchProvider = ChangeNotifierProvider(
  (ref) => SearchProvider(ref.read),
);

class SearchProvider extends ChangeNotifier {
  Reader reader;
  SearchProvider(this.reader);

  Future<bool> onFollowPressed(String otherUserID) async {
    final currentUserId = reader(userDataProvider).userId;
    final bool isDone = await FireSearch.followPressed(
      currentUserId: currentUserId!,
      otherUserID: otherUserID,
    );

    return isDone;
  }

  Future<bool> onUnFollowPressed(String otherUserID) async {
    final currentUserId = reader(userDataProvider).userId;
    final bool isDone = await FireSearch.unFollowPressed(
      currentUserId: currentUserId!,
      otherUserID: otherUserID,
    );
    return isDone;
  }
}
