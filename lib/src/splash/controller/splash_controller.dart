import 'package:casaflutterapp/utils/preference_manager.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/string_constant.dart';
import '../../common/service/global_navigator_service.dart';
import '../model/splash_models.dart';

class SplashController extends GetxController {
// ========= VARIABLES ========= //
  RxString netImage = "".obs;
  RxInt dayIndex = 0.obs;
  List<SplashModels> splashLogos = [
    SplashModels(logoId: 0, logo: ImageConstants.logoTwo),
    SplashModels(logoId: 1, logo: ImageConstants.logoFour),
    SplashModels(logoId: 2, logo: ImageConstants.logoSix),
    SplashModels(logoId: 3, logo: ImageConstants.logoFive),
    SplashModels(logoId: 4, logo: ImageConstants.logoOne),
    SplashModels(logoId: 5, logo: ImageConstants.logoThree),
    SplashModels(logoId: 6, logo: ImageConstants.logoEight),
    SplashModels(logoId: 7, logo: ImageConstants.logoNine),
    SplashModels(logoId: 8, logo: ImageConstants.logoSeven),
    SplashModels(logoId: 9, logo: ImageConstants.logoTen),
    SplashModels(logoId: 10, logo: ImageConstants.logoEleven),
    SplashModels(logoId: 11, logo: ImageConstants.logoTwelve),
    SplashModels(logoId: 12, logo: ImageConstants.logoThirteen),
    SplashModels(logoId: 13, logo: ImageConstants.logoFourteen),
    SplashModels(logoId: 14, logo: ImageConstants.logoFifteen),
    SplashModels(logoId: 15, logo: ImageConstants.splashBackground),
  ];

  final RxInt _currentSlot = 0.obs;

  int get currentSlot => _currentSlot.value;

  String get currentLogo =>
      splashLogos.firstWhere((e) => e.logoId == _currentSlot.value).logo;

// ========== STATES ========== //
  @override
  void onInit() {
    super.onInit();
    dayIndex(DateTime.now().weekday);
    Future.delayed(const Duration(seconds: 5), () {
      navigatorKey.currentContext?.goNamed(RouteNames.signIn);
    });
  }

  Future<void> initSplashLogo() async {
    final now = DateTime.now();
    final daysSinceEpoch = now.difference(DateTime.now()).inDays;
    final slotOfDay = now.hour ~/ 3;
    final totalSlot = (daysSinceEpoch * 8 + slotOfDay) % splashLogos.length;

    final lastSlot =
        PreferenceManager.getInt(PreferenceManager.lastSplashSlot) ?? -1;

    if (totalSlot != lastSlot) {
      await PreferenceManager.setData(PreferenceManager.lastSplashSlot, totalSlot);
    }

    _currentSlot.value = totalSlot;
  }
}
