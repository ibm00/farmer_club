import 'dart:async';

import 'package:farmer_club/data/firebase_services/fire_search.dart';
import 'package:farmer_club/data/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user_model.dart';

final allUsersProvider = FutureProvider.autoDispose<List<UserModel>?>(
  (ref) async {
    final searchWord =
        ref.watch(searchProvider.select((value) => value.lastSearchWord));
    List<UserModel>? users =
        await FireSearch.getAllOtherUsers(ref.read(userDataProvider).userId!);
    if (searchWord.isNotEmpty) {
      users = users!
          .where((userModel) => userModel.name!.startsWith(searchWord))
          .toList();
    }
    if (users == null) return null;
    return users;
  },
);

final searchProvider = ChangeNotifierProvider.autoDispose(
  (ref) => SearchProvider(ref.read),
);

class SearchProvider extends ChangeNotifier {
  Reader reader;
  SearchProvider(this.reader);

  String lastSearchWord = "";
  void onSearchFieldChanged(String value) {
    final String searchWord = value.trim();
    if (lastSearchWord == searchWord) return;
    lastSearchWord = searchWord;
    notifyListeners();
  }

  Future<int?> onFollowPressed(String otherUserID) async {
    final currentUserId = reader(userDataProvider).userId;
    final Map? followingAndFollowers = await FireSearch.followPressed(
      currentUserId: currentUserId!,
      otherUserID: otherUserID,
    );
    if (followingAndFollowers == null) return null;
    _updateFollowingNumOnUI(followingAndFollowers['currentUserFollowingNum']);
    _updateFollowerNumOnUI(followingAndFollowers['otherUserFollowersNum']);
    return followingAndFollowers['otherUserFollowersNum'];
  }

  Future<int?> onUnFollowPressed(String otherUserID) async {
    final currentUserId = reader(userDataProvider).userId;
    final Map? followingAndFollowers = await FireSearch.unFollowPressed(
      currentUserId: currentUserId!,
      otherUserID: otherUserID,
    );
    if (followingAndFollowers == null) return null;
    _updateFollowingNumOnUI(followingAndFollowers['currentUserFollowingNum']);
    _updateFollowerNumOnUI(followingAndFollowers['otherUserFollowersNum']);
    return followingAndFollowers['otherUserFollowersNum'];
  }

  void _updateFollowingNumOnUI(int currentUserFollowingNum) {
    reader(userDataProvider).updateFollowingNum(currentUserFollowingNum);
  }

  void _updateFollowerNumOnUI(int otherUserFollowersNum) {
    reader(userDataProvider).updateFollowerNum(otherUserFollowersNum);
  }
}
