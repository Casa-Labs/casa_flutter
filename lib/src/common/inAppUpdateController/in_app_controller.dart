import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

class AppUpdateController extends GetxController {
  var updateAvailable = false.obs;
  AppUpdateInfo? _updateInfo;

  @override
  void onInit() {
    checkForUpdate();
    super.onInit();
  }

  // Check for updates
  Future<void> checkForUpdate() async {
    try {
      _updateInfo = await InAppUpdate.checkForUpdate();
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        updateAvailable.value = true;
      }
    } catch (e) {
      print("Error checking for update: $e");
    }
  }

  // Start Flexible Update
  Future<void> startFlexibleUpdate() async {
    if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
    }
  }

  // Start Immediate Update
  Future<void> startImmediateUpdate() async {
    if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.performImmediateUpdate();
    }
  }
}
