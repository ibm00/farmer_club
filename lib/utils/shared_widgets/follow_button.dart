import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/search_screen.dart/search_provider.dart';
import '../constants/styles.dart';
import 'button_widget.dart';

class FollowButton extends StatefulWidget {
  final bool isInsideProfile;
  final String otherUserID;
  final bool isFollow;
  final void Function(int)? doThisAftherPress;
  const FollowButton({
    required this.isInsideProfile,
    required this.otherUserID,
    required this.isFollow,
    this.doThisAftherPress,
    Key? key,
  }) : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFollowState;
  @override
  void initState() {
    isFollowState = widget.isFollow;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return ButtonWidget(
          elevation: widget.isInsideProfile
              ? 0
              : isFollowState
                  ? 0
                  : 2,
          width: widget.isInsideProfile ? 160 : 97,
          hight: widget.isInsideProfile ? 42 : 30,
          title: isFollowState ? "إلغاء المتابعة" : "متابعة",
          textStyle: kTextStyleReg11.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: widget.isInsideProfile ? 16 : 12,
          ),
          onButtonPressed: () async {
            final int? otherUserFollowersNum =
                await onButtonPressed(ref.read, widget.otherUserID);
            if (widget.isInsideProfile) {
              ref.refresh(allUsersProvider);
              widget.doThisAftherPress!(otherUserFollowersNum!);
            }
          },
          color: isFollowState ? Colors.grey[400]! : kPrimaryTextColor,
          icon: widget.isInsideProfile ? const Icon(Icons.add) : null,
        );
      },
    );
  }

  Future<int?> onButtonPressed(Reader reader, String otherUserID) async {
    setState(() {
      isFollowState = !isFollowState;
    });
    if (isFollowState) {
      final int? otherUserFollowersNum =
          await reader(searchProvider).onFollowPressed(otherUserID);

      if (otherUserFollowersNum == null) {
        setState(() {
          isFollowState = !isFollowState;
        });
      }
      return otherUserFollowersNum;
    } else {
      final int? otherUserFollowersNum =
          await reader(searchProvider).onUnFollowPressed(otherUserID);
      if (otherUserFollowersNum == null) {
        setState(() {
          isFollowState = !isFollowState;
        });
      }
      return otherUserFollowersNum;
    }
  }
}
