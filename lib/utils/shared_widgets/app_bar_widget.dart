import '../../constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasDrawer;
  final bool hasBackButton;
  const AppBarWidget({
    required this.title,
    this.hasDrawer = false,
    this.hasBackButton = true,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Text(
            title,
            style: kTextStyleBold26,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
      centerTitle: true,
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 8, width: 15),
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    !hasDrawer
                        ? Navigator.pop(context)
                        : Scaffold.of(context).openDrawer();
                  },
                  icon: hasDrawer
                      ? SvgPicture.asset('assets/images/Icon_open_menu.svg')
                      : const Icon(Icons.arrow_back_ios, size: 30),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(85);
}
