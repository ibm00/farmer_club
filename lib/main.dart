import 'package:farmer_club/constants/styles.dart';
import 'package:farmer_club/presentation/shared_widgets/icons_wrapper.dart';
import 'package:flutter/material.dart';

import 'presentation/shared_widgets/textFieldWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Hello there'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const IconWrapper(Icons.person_outline_rounded),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextFieldWidget(
                      onSaving: (v) {},
                      validator: (String? x) {
                        if (x!.length > 5) {
                          return null;
                        } else {
                          return 'more than 5';
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
