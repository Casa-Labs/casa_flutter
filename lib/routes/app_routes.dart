import 'package:casa_flutter/src/auth/view/screens/sign_in_screen.dart';
import 'package:casa_flutter/src/auth/view/screens/welcome_auth_screen.dart';
import 'package:casa_flutter/src/faq/view/screens/faq_screen.dart';
import 'package:go_router/go_router.dart';

import '../src/common/service/global_navigator_service.dart';
import '../src/home/view/screens/bottom_navigator.dart';
import '../src/home/view/screens/home_screen.dart';
import '../src/location/view/screens/location_screen.dart';
import '../src/notifications/view/screens/notifications_screen.dart';
import '../src/order/view/screens/order_details_screen.dart';
import '../src/order/view/screens/track_shipment.dart';
import '../src/splash/view/screens/splash_screen.dart';
import '../src/wishlist/view/screens/create_closet_screen.dart';
import '../src/wishlist/view/screens/wishlist_item_screen.dart';
import '../src/wishlist/view/screens/wishlist_screen.dart';

// Private: Do NOT use these for navigation
class _AppPaths {
  static const String splash = '/';
  static const String welcomeAuth = '/welcomeAuth';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String notifications = '/notifications';
  static const String location = '/location';
  static const String faq = '/faq';
  static const String navigation = '/navigation';
  static const String orderDetails = '/orderDetails';
  static const String trackShipment = '/trackShipment';
  static const String wishlist = '/wishlist';
  static const String createCloset = '/createCloset';
  static const String wishlistItem = '/wishlistItem';
}

// Public: Use these for named navigation
class RouteNames {
  static const String splash = 'splash';
  static const String welcomeAuth = 'welcomeAuth';
  static const String signIn = 'signIn';
  static const String home = 'home';
  static const String notifications = 'notifications';
  static const String location = 'location';
  static const String faq = 'faq';
  static const String navigation = 'navigation';
  static const String orderDetails = 'orderDetails';
  static const String trackShipment = 'trackShipment';
  static const String wishlist = '/wishlist';
  static const String createCloset = '/createCloset';
  static const String wishlistItem = '/wishlistItem';
}

// Central GoRouter instance
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: _AppPaths.splash,
      name: RouteNames.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: _AppPaths.welcomeAuth,
      name: RouteNames.welcomeAuth,
      builder: (context, state) => WelcomeAuthScreen(),
    ),
    GoRoute(
      path: _AppPaths.signIn,
      name: RouteNames.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: _AppPaths.home,
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: _AppPaths.notifications,
      name: RouteNames.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: _AppPaths.location,
      name: RouteNames.location,
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: _AppPaths.faq,
      name: RouteNames.faq,
      builder: (context, state) => FAQScreen(),
    ),
    GoRoute(
      path: _AppPaths.navigation,
      name: RouteNames.navigation,
      builder: (context, state) => const NavPage(),
    ),
    GoRoute(
      path: _AppPaths.orderDetails,
      name: RouteNames.orderDetails,
      builder: (context, state) => OrderDetails(),
    ),
    GoRoute(
      path: _AppPaths.trackShipment,
      name: RouteNames.trackShipment,
      builder: (context, state) => TrackShipment(),
    ),
    GoRoute(
      path: _AppPaths.wishlist,
      name: RouteNames.wishlist,
      builder: (context, state) => WishlistScreen(),
    ),
    GoRoute(
      path: _AppPaths.createCloset,
      name: RouteNames.createCloset,
      builder: (context, state) => CreateClosetScreen(),
    ),
    GoRoute(
      path: _AppPaths.wishlistItem,
      name: RouteNames.wishlistItem,
      builder: (context, state) => WishlistItemScreen(),
    ),
  ],
);
