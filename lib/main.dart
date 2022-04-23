import 'package:easy_localization/easy_localization.dart';
import 'package:farmer_club/utils/helpers/routes.dart';
import 'package:farmer_club/utils/translation/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/root_screen/root_screen.dart';
import 'utils/constants/styles.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      startLocale: const Locale('ar'),
      assetLoader: const CodegenLoader(),
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('ar'),
      child: DevicePreview(
        enabled: false,
        builder: (context) => const ProviderScope(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Farmer Club',
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xff299A0B,
            kPrimaryColorMap,
          ),
          primaryColor: kPrimaryColor,
          fontFamily: 'Nunito',
        ),
        initialRoute: RooteScreen.routeName,
        onGenerateRoute: RoutesHelper.generateRoute,
      ),
    );
  }
}
