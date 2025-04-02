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
    SplashModels(logoId: 0, logo: ImageConstants.splashBackground),
    SplashModels(logoId: 1, logo: ImageConstants.mondayLogo),
    SplashModels(logoId: 2, logo: ImageConstants.tuesdayLogo),
    SplashModels(logoId: 3, logo: ImageConstants.wednesdayLogo),
    SplashModels(logoId: 4, logo: ImageConstants.thursdayLogo),
    SplashModels(logoId: 5, logo: ImageConstants.fridayLogo),
    SplashModels(logoId: 6, logo: ImageConstants.saturdayLogo),
    SplashModels(logoId: 7, logo: ImageConstants.sundayLogo),
  ];

// ========== STATES ========== //
  @override
  void onInit() {
    super.onInit();
    dayIndex(DateTime.now().weekday);
    Future.delayed(const Duration(seconds: 5), () {
      navigatorKey.currentContext?.goNamed(RouteNames.signIn);
    });
  }
}
