import 'package:casa_flutter/src/common/widgets/show_toast.dart'
    show scaffoldMessengerKey;
import 'package:casa_flutter/theme/light_theme.dart';
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
      title: 'Casa Flutter',
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
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); // 3rd
}
