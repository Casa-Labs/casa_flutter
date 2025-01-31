import 'package:casa_flutter/src/home/view/screens/home_screen.dart';
import 'package:casa_flutter/src/notifications/view/screens/notifications_screen.dart';
import 'package:casa_flutter/src/home/view/screens/bottom_navigator.dart';
import 'package:go_router/go_router.dart';

// Define all routes paths
class AppRoutes {
  static const String main = '/';
  static const String home = '/home';
  static const String notifications = '/notifications';
}

// Define all route names
class RouteNames {
  static const String home = 'home';
  static const String notifications = 'notifications';
}

// Central GoRouter instance
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.main,
      name: 'main',
      builder: (context, state) => const NavPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      name: 'notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
);
