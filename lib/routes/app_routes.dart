import 'package:casaflutter/src/auth/view/screens/body_type_preferences_screen.dart';
import 'package:casaflutter/src/auth/view/screens/fit_preferences_screen.dart';
import 'package:casaflutter/src/auth/view/screens/personal_details_screen.dart';
import 'package:casaflutter/src/auth/view/screens/sign_up_screen.dart';
import 'package:casaflutter/src/auth/view/screens/style_preferences_screen.dart';
import 'package:casaflutter/src/auth/view/screens/verify_your_email.dart';
import 'package:casaflutter/src/cart/view/screens/cart_screen.dart';
import 'package:casaflutter/src/common/widgets/development_screen.dart';
import 'package:casaflutter/src/explore/view/screens/products_list_screen.dart';
import 'package:casaflutter/src/explore/view/screens/store_screen.dart';
import 'package:casaflutter/src/location/model/get_user_response_model.dart';
import 'package:casaflutter/src/location/view/screens/addresses_list.dart';
import 'package:casaflutter/src/order/view/screens/current_orders_screen.dart';
import 'package:casaflutter/src/order/view/screens/order_review_screen.dart';
import 'package:casaflutter/src/payment/view/screens/payment_options_screen.dart';
import 'package:casaflutter/src/profile/view/screens/contact_us_screen.dart';
import 'package:casaflutter/src/profile/view/screens/profile_screen.dart';
import 'package:casaflutter/src/search/view/screens/search_view_screen.dart';
import 'package:casaflutter/utils/preference_manager.dart';
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
  static const String forgotPassword = '/forgotPassword';
  static const String verifyEmail = '/verifyEmail';
  static const String changePassword =
      '/changePassword/:email/:isFromWithinApp';
  static const String home = '/home';
  static const String notifications = '/notifications';
  static const String location = '/location/:isEdit';
  static const String faq = '/faq';
  static const String navigation = '/navigation';
  static const String orderDetails = '/orderDetails';
  static const String trackShipment = '/trackShipment';
  static const String wishlist = '/wishlist';
  static const String createCloset = '/createCloset';
  static const String wishlistItem = '/wishlistItem';
  static const String explore = '/explore';
  static const String profile = '/profile';
  static const String development = '/development';
  static const String myOrders = '/myOrders';
  static const String store = '/store/:id';
  static const String productList = '/productList';
  static const String productDescription = '/productDescription/:id';
  static const String paymentOptions = '/paymentOptions';
  static const String cart = '/cart';
  static const String orderReview = '/orderReview';
  static const String contactUs = '/contactUs';
  static const String searchView = '/searchView';
  static const String addressList = '/addressList';
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
  static const String contactUs = 'contactUs';
  static const String searchView = 'searchView';
  static const String addressList = 'addressList';
}

// Central GoRouter instance
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  redirect: (context, state) {
    final token = PreferenceManager.getString(PreferenceManager.token);
    final isLoggedIn = token != null && token.isNotEmpty;
    final isLoggingIn = state.fullPath == _AppPaths.signIn;

    if (isLoggedIn && isLoggingIn) {
      // User is logged in and tries to go to login again -> redirect to main screen
      return _AppPaths.navigation;
    }

    // Let user access all other routes freely (including navigation without auth)
    return null;
  },
  debugLogDiagnostics: true,
  initialLocation: _AppPaths.splash,
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if ((PreferenceManager.getBool(PreferenceManager.isCompletedTutorial) ?? false)) {
          router.goNamed(RouteNames.navigation, extra: false);
        } else {
          router.goNamed(RouteNames.navigation, extra: true);
        }
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
      builder: (context, state) {
        final email = state.pathParameters['email'] ?? '';
        final isFromWithinApp =
            bool.parse(state.pathParameters['isFromWithinApp'] ?? '');
        return ChangePasswordScreen(
          email: email,
          isFromWithinApp: isFromWithinApp,
        );
      },
    ),
    GoRoute(
      path: _AppPaths.home,
      name: RouteNames.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: _AppPaths.notifications,
      name: RouteNames.notifications,
      builder: (context, state) => NotificationsScreen(),
    ),
    GoRoute(
      path: _AppPaths.location,
      name: RouteNames.location,
      builder: (context, state) {
        Addresses? address;
        if (state.extra != null) {
          address = state.extra as Addresses;
        }
        final isEdit = bool.parse(state.pathParameters['isEdit'] ?? '');
        return LocationScreen(
          addresses: address,
          isEdit: isEdit,
        );
      },
    ),
    GoRoute(
      path: _AppPaths.faq,
      name: RouteNames.faq,
      builder: (context, state) => FAQScreen(),
    ),
    GoRoute(
      path: _AppPaths.navigation,
      name: RouteNames.navigation,
      builder: (context, state) {
        bool isFirstLaunch = false;
        if (state.extra != null) {
          isFirstLaunch = state.extra as bool;
        }
        return NavPage(isFirstLaunch: isFirstLaunch);
      },
    ),

    // TODO : Uncomment later but avoid passing the object as it may change from the API

    // GoRoute(
    //   path: _AppPaths.orderDetails,
    //   name: RouteNames.orderDetails,
    //   builder: (context, state) {
    //     final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
    //     final OrderedItems selectedItem = args["selectedItem"];
    //     final OrderModel orderData = args["orderData"];
    //
    //     return OrderDetails(orderItem: selectedItem, orderData: orderData);
    //   },
    // ),
    // GoRoute(
    //   path: _AppPaths.trackShipment,
    //   name: RouteNames.trackShipment,
    //   builder: (context, state) {
    //     final orderItem = state.extra as OrderedItems?;
    //     return TrackShipment(orderItem: orderItem!);
    //   },
    // ),
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
      builder: (context, state) {
        final storeId = state.pathParameters['id'] as String;
        return StoreScreen(
          id: storeId,
        );
      },
    ),
    GoRoute(
      path: _AppPaths.productList,
      name: RouteNames.productList,
      builder: (context, state) => ProductsListScreen(),
    ),
    GoRoute(
      path: _AppPaths.productDescription,
      name: RouteNames.productDescription,
      builder: (context, state) {
        final productId = state.pathParameters['id'] as String;
        return ProductDescriptionScreen(id: productId);
      },
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
    GoRoute(
      path: _AppPaths.contactUs,
      name: RouteNames.contactUs,
      builder: (context, state) => ContactUsScreen(),
    ),
    GoRoute(
      path: _AppPaths.searchView,
      name: RouteNames.searchView,
      builder: (context, state) => SearchViewScreen(),
    ),
    GoRoute(
      path: _AppPaths.addressList,
      name: RouteNames.addressList,
      builder: (context, state) => AddressesList(),
    ),
  ],
);
