import 'package:farmer_club/utils/helpers/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/roote_screen/roote_screen.dart';
import 'utils/constants/styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) =>
          const ProviderScope(child: MyApp()), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xff299A0B,
            kPrimaryColorMap,
          ),
          primaryColor: kPrimaryColor,
          fontFamily: 'Nunito',
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('ar'),
        // home: MyHomePage(),
        initialRoute: RooteScreen.routeName,
        onGenerateRoute: RoutesHelper.generateRoute,
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const Drawer(child: Text('Farmer Club')),
//       backgroundColor: kBackgroundColor,
//       appBar: const AppBarWidget(title: 'Farmer Club', hasDrawer: true),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               const SizedBox(height: 15),
//               Row(
//                 children: [
//                   const IconWrapper(Icons.person_outline_rounded),
//                   const SizedBox(width: 6),
//                   Expanded(
//                     child: TextFieldWidget(
//                       hintText: 'hint',
//                       onSaving: (v) {},
//                       validator: (String? x) {
//                         if (x!.length > 5) {
//                           return null;
//                         } else {
//                           return 'more than 5';
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               PostBoxWidget(
//                 Post(
//                   isMyPost: true,
//                   postImageUrl:
//                       'https://images.ctfassets.net/hrltx12pl8hq/euxCffMOPuxAnPLcN3nzW/eb14f1deaa1e6edce8981124825aefb9/ULOHP.png?fit=fill&w=800&h=400',
//                   commentsNum: 17,
//                   userName: 'Ibrahem Saad',
//                   userImageUrl:
//                       'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
//                   postDate: '8 Nov.',
//                   postText:
//                       'Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going.',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               PostBoxWidget(
//                 Post(
//                   isMyPost: false,
//                   postImageUrl:
//                       'https://images.ctfassets.net/hrltx12pl8hq/euxCffMOPuxAnPLcN3nzW/eb14f1deaa1e6edce8981124825aefb9/ULOHP.png?fit=fill&w=800&h=400',
//                   commentsNum: 17,
//                   userName: 'Ibrahem Saad',
//                   userImageUrl:
//                       'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
//                   postDate: '8 Nov.',
//                   postText:
//                       'Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going.',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Row(
//               //   children: [
//               //     // SizedBox(width: 100),
//               //     Expanded(
//               //       child: ButtonWidget(
//               //         title: 'photo',
//               //         onButtonPressed: () {
//               //           Navigator.of(context).push(
//               //             MaterialPageRoute(builder: (context) => MyHomePage()),
//               //           );
//               //         },
//               //         // width: 92,
//               //         // hight: 32,
//               //         // color: Color(0xffF8F9FB),
//               //         // borderRadius: 10,
//               //         // textStyle: kTextStyleReg11,
//               //         // textColor: Color(0xff444D6E),
//               //         // elevation: 5,
//               //         // icon: Icon(Icons.add, size: 12, color: Color(0xff444D6E)),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// void fun1() {
//   final list = [44, 444, 55];

//   final list2 = [54, 54, 5, 545454, 5454];
//   final finalList = [];
//   list2.forEach((element) {
//     list.contains(element);
//     finalList.add(element);
//   });

//   final i = FirebaseFirestore.instance.collection("posts").doc();
//   i.set({"data": i.id});
// }
