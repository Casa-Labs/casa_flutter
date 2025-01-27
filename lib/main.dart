import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_routes.dart';

Future<void> main() async {
  await GetStorage.init(); //keep first
  WidgetsFlutterBinding.ensureInitialized(); //2nd
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]); // mandatory for sizer

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,

      // home: const SplashScreen(),
      // theme: lightMode,
      // darkTheme: darkMode,
      // themeMode: ThemeController.prefThemeMode(),
    );
  }
}
