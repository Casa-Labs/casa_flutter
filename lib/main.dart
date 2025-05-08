import 'dart:ui';

import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_routes.dart';

Future<void> main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: 'CASA',
      theme: lightMode,
      // home: const SplashScreen(),
      // theme: lightMode,
      // darkTheme: darkMode,
      // themeMode: ThemeController.prefThemeMode(),
    );
  }
}

Future<void> setup() async {
  await GetStorage.init(); //keep first
  WidgetsFlutterBinding.ensureInitialized(); //2nd
  await Firebase.initializeApp();
  // Enable Crashlytics Logging
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // Set up error handling
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); // 3rd
}
