import 'package:casa_flutter/src/auth/view/screens/body_type_preferences_screen.dart';
import 'package:casa_flutter/src/auth/view/screens/delivery_address_screen.dart';
import 'package:casa_flutter/src/auth/view/screens/fit_preferences_screen.dart';
import 'package:casa_flutter/src/auth/view/screens/personal_details_screen.dart';
import 'package:casa_flutter/src/auth/view/screens/sign_up_screen.dart';
import 'package:casa_flutter/src/auth/view/screens/style_preferences_screen.dart';
import 'package:casa_flutter/src/auth/view/screens/verify_your_email.dart';
import 'package:casa_flutter/src/cart/view/screens/cart_screen.dart';
import 'package:casa_flutter/src/common/widgets/development_screen.dart';
import 'package:casa_flutter/src/explore/view/screens/products_list_screen.dart';
import 'package:casa_flutter/src/explore/view/screens/store_screen.dart';
import 'package:casa_flutter/src/order/model/order_models.dart';
import 'package:casa_flutter/src/order/view/screens/current_orders_screen.dart';
import 'package:casa_flutter/src/order/view/screens/order_review_screen.dart';
import 'package:casa_flutter/src/payment/view/screens/payment_options_screen.dart';
import 'package:casa_flutter/src/profile/view/screens/profile_screen.dart';
import 'package:casa_flutter/utils/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/auth/view/screens/change_password_screen.dart';
import '../src/auth/view/screens/forgot_password_screen.dart';
import '../src/auth/view/screens/sign_in_screen.dart';
import '../src/auth/view/screens/welcome_auth_screen.dart';
import '../src/common/service/global_navigator_service.dart';
import '../src/explore/view/screens/explore_screen.dart';
import '../src/explore/view/screens/product_description_screen.dart';
import '../src/faq/view/screens/faq_screen.dart';
import '../src/home/view/screens/bottom_navigator.dart';
import '../src/home/view/screens/home_screen.dart';
import '../src/location/view/screens/location_screen.dart';
import '../src/notifications/view/screens/notifications_screen.dart';
import '../src/order/view/screens/order_details_screen.dart';
import '../src/order/view/screens/track_shipment.dart';
import '../src/search/view/screens/search_screen.dart';
import '../src/splash/view/screens/splash_screen.dart';
import '../src/wishlist/view/screens/create_closet_screen.dart';
import '../src/wishlist/view/screens/wishlist_item_screen.dart';
import '../src/wishlist/view/screens/wishlist_screen.dart';

// Private: Do NOT use these for navigation
class _AppPaths {
  static const String splash = '/';
  static const String welcomeAuth = '/welcomeAuth';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String personalDetails = '/personalDetails';
  static const String stylePreferences = '/stylePreferences';
  static const String bodyTypePreferences = '/bodyTypePreferences';
  static const String fitPreferences = '/fitPreferences';
  static const String deliveryAddress = '/deliveryAddress';
  static const String forgotPassword = '/forgotPassword';
  static const String verifyEmail = '/verifyEmail';
  static const String changePassword = '/changePassword';
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
  static const String explore = '/explore';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String development = '/development';
  static const String myOrders = '/myOrders';
  static const String store = '/store';
  static const String productList = '/productList';
  static const String productDescription = '/productDescription';
  static const String paymentOptions = '/paymentOptions';
  static const String cart = '/cart';
  static const String orderReview = '/orderReview';
}

// Public: Use these for named navigation
class RouteNames {
  static const String splash = 'splash';
  static const String welcomeAuth = 'welcomeAuth';
  static const String signIn = 'signIn';
  static const String forgotPassword = 'forgotPassword';
  static const String verifyEmail = 'verifyEmail';
  static const String changePassword = 'changePassword';
  static const String personalDetails = 'personalDetails';
  static const String stylePreferences = 'stylePreferences';
  static const String bodyTypePreferences = 'bodyTypePreferences';
  static const String fitPreferences = 'fitPreferences';
  static const String deliveryAddress = 'deliveryAddress';
  static const String home = 'home';
  static const String notifications = 'notifications';
  static const String location = 'location';
  static const String faq = 'faq';
  static const String navigation = 'navigation';
  static const String orderDetails = 'orderDetails';
  static const String trackShipment = 'trackShipment';
  static const String wishlist = 'wishlist';
  static const String createCloset = 'createCloset';
  static const String wishlistItem = 'wishlistItem';
  static const String explore = 'explore';
  static const String search = 'search';
  static const String profile = 'profile';
  static const String development = 'development';
  static const String myOrders = 'myOrders';
  static const String signUp = 'signUp';
  static const String store = 'store';
  static const String productList = 'productList';
  static const String productDescription = 'productDescription';
  static const String paymentOptions = 'paymentOptions';
  static const String cart = 'cart';
  static const String orderReview = 'orderReview';
}

// Central GoRouter instance
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  redirect: (context, state) {
    bool isLoggedIn = false;
    final token = PreferenceManager.getString(PreferenceManager.token);
    if (token != null && token.isNotEmpty) {
      isLoggedIn = true;
    }
    final isLoggingIn = state.fullPath == _AppPaths.signIn;

    if (isLoggedIn && isLoggingIn) {
      return _AppPaths.navigation;
    }

    return null;
  },
  debugLogDiagnostics: true,
  initialLocation: _AppPaths.splash,
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.goNamed(_AppPaths.navigation);
      },
    );
    return const Scaffold();
  },
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
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: _AppPaths.signUp,
      name: RouteNames.signUp,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: _AppPaths.personalDetails,
      name: RouteNames.personalDetails,
      builder: (context, state) => PersonalDetailsScreen(),
    ),
    GoRoute(
      path: _AppPaths.stylePreferences,
      name: RouteNames.stylePreferences,
      builder: (context, state) => StylePreferencesScreen(),
    ),
    GoRoute(
      path: _AppPaths.bodyTypePreferences,
      name: RouteNames.bodyTypePreferences,
      builder: (context, state) => BodyTypePreferencesScreen(),
    ),
    GoRoute(
      path: _AppPaths.fitPreferences,
      name: RouteNames.fitPreferences,
      builder: (context, state) => FitPreferencesScreen(),
    ),
    GoRoute(
      path: _AppPaths.deliveryAddress,
      name: RouteNames.deliveryAddress,
      builder: (context, state) => DeliveryAddressScreen(),
    ),
    GoRoute(
      path: _AppPaths.forgotPassword,
      name: RouteNames.forgotPassword,
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      path: _AppPaths.verifyEmail,
      name: RouteNames.verifyEmail,
      builder: (context, state) => VerifyYourEmail(),
    ),
    GoRoute(
      path: _AppPaths.changePassword,
      name: RouteNames.changePassword,
      builder: (context, state) => ChangePasswordScreen(),
    ),
    GoRoute(
      path: _AppPaths.home,
      name: RouteNames.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: _AppPaths.notifications,
      name: RouteNames.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: _AppPaths.location,
      name: RouteNames.location,
      builder: (context, state) => LocationScreen(),
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
      builder: (context, state) {
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        final OrderedItems selectedItem = args["selectedItem"];
        final OrderModel orderData = args["orderData"];

        return OrderDetails(orderItem: selectedItem, orderData: orderData);
      },
    ),
    GoRoute(
      path: _AppPaths.trackShipment,
      name: RouteNames.trackShipment,
      builder: (context, state) {
        final orderItem = state.extra as OrderedItems?;
        return TrackShipment(orderItem: orderItem!);
      },
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
    GoRoute(
      path: _AppPaths.explore,
      name: RouteNames.explore,
      builder: (context, state) => ExploreScreen(),
    ),
    GoRoute(
      path: _AppPaths.search,
      name: RouteNames.search,
      builder: (context, state) => SearchScreen(),
    ),
    GoRoute(
      path: _AppPaths.profile,
      name: RouteNames.profile,
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: _AppPaths.development,
      name: RouteNames.development,
      builder: (context, state) => DevelopmentScreen(),
    ),
    GoRoute(
      path: _AppPaths.myOrders,
      name: RouteNames.myOrders,
      builder: (context, state) {
        final bool flag = state.extra as bool? ?? true;
        return CurrentOrdersScreen(isHistory: flag);
      },
    ),
    GoRoute(
      path: _AppPaths.store,
      name: RouteNames.store,
      builder: (context, state) => StoreScreen(),
    ),
    GoRoute(
      path: _AppPaths.productList,
      name: RouteNames.productList,
      builder: (context, state) => ProductsListScreen(),
    ),
    GoRoute(
      path: _AppPaths.productDescription,
      name: RouteNames.productDescription,
      builder: (context, state) => ProductDescriptionScreen(),
    ),
    GoRoute(
      path: _AppPaths.paymentOptions,
      name: RouteNames.paymentOptions,
      builder: (context, state) => PaymentOptionsScreen(),
    ),
    GoRoute(
      path: _AppPaths.cart,
      name: RouteNames.cart,
      builder: (context, state) => CartScreen(),
    ),
    GoRoute(
      path: _AppPaths.orderReview,
      name: RouteNames.orderReview,
      builder: (context, state) => OrderReviewScreen(),
    ),
  ],
);
