import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/string_constant.dart';
import '../../common/service/global_navigator_service.dart';

class SplashController extends GetxController {
// ========= VARIABLES ========= //
  RxString netImage = "".obs;
  List<String> logoImages = [
    ImageConstants.mondayLogo,
    ImageConstants.tusedayLogo,
    ImageConstants.wednesdayLogo,
    ImageConstants.thursdayLogo,
    ImageConstants.fridayLogo,
    ImageConstants.saturdayLogo,
    ImageConstants.sundayLogo
  ];

// ========== STATES ========== //
  @override
  void onInit() {
    super.onInit();
    int dayIndex = DateTime.now().weekday - 1;

    if (dayIndex >= 0 && dayIndex < logoImages.length) {
      netImage.value = logoImages[dayIndex];
    }

    Future.delayed(const Duration(seconds: 3), () {
      navigatorKey.currentContext?.goNamed(RouteNames.signIn);
    });
  }
}
