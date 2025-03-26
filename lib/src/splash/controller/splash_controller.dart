import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';
import '../../common/service/global_navigator_service.dart';

class SplashController extends GetxController {
  RxString netImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      navigatorKey.currentContext?.goNamed(RouteNames.signIn);
    });
  }
}
