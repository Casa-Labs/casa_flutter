import 'package:go_router/go_router.dart';

import '../src/home/view/screens/home_screen.dart';

// Define all routes
class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

// Central GoRouter instance
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    // GoRoute(
    //   path: AppRoutes.profile,
    //   name: 'profile',
    //   builder: (context, state) => const ProfileScreen(),
    // ),
    // GoRoute(
    //   path: AppRoutes.settings,
    //   name: 'settings',
    //   builder: (context, state) => const SettingsScreen(),
    // ),
  ],
);
