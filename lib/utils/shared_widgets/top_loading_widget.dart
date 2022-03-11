import 'package:farmer_club/utils/constants/styles.dart';
import 'package:flutter/material.dart';

import 'circular_loading_widget.dart';

class TopLoadingWidget extends StatelessWidget {
  const TopLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black38,
      child: const CircularLoadingWidget(),
    );
  }
}
