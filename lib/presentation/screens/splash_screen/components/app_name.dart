import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'Farmer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Club',
          textAlign: TextAlign.center,
          style: TextStyle(
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(0, -12),
              )
            ],
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
