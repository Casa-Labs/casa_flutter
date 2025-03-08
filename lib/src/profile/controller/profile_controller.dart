import 'dart:convert';
import 'dart:io';

import 'package:casa_flutter/src/auth/controller/auth_controller.dart';
import 'package:casa_flutter/src/auth/model/auth_models.dart';
import 'package:casa_flutter/src/auth/model/service/auth_service.dart';
import 'package:casa_flutter/utils/preference_manager.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProfileController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //

  bool isSelectApple = Platform.isIOS ? true : false;
  bool isSelectPlay = Platform.isAndroid ? true : false;
  RxBool isUserDeleteProgress = false.obs;
  RxBool isUserDeleted = false.obs;
  RxString message = ''.obs;
  RxString loggedInUser = ''.obs;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  @override
  void onReady() {
    getLoggedInUserName();
    super.onReady();
  }

  selectApple() {
    isSelectPlay = false;
    isSelectApple = true;
    update();
  }

  selectPlay() {
    isSelectApple = false;
    isSelectPlay = true;
    update();
  }

  void shareApp(String link, String appName) {
    final message = isSelectPlay ? 'Android: $link' : 'iOS: $link';

    Share.share(message, subject: 'Check out $appName');
  }

  void getLoggedInUserName() {
    // get user details
    final userDetailsData = PreferenceManager.getString(
      PreferenceManager.userDetails,
    );
    var userDetailsMap = <String, dynamic>{};
    if (userDetailsData != null) {
      userDetailsMap = json.decode(userDetailsData.trim());
    }
    final userDetails = User.fromJson(userDetailsMap);
    if (userDetails.id != null) {
      loggedInUser(userDetails.name);
    }
  }

// ========== APIs FUNCTIONS ========== //
  Future<void> deleteUserCall() async {
    // get user details
    final userDetailsData = PreferenceManager.getString(
      PreferenceManager.userDetails,
    );
    var userDetailsMap = <String, dynamic>{};
    if (userDetailsData != null) {
      userDetailsMap = json.decode(userDetailsData.trim());
    }
    final userDetails = User.fromJson(userDetailsMap);
    if (userDetails.id != null) {
      isUserDeleteProgress(true);
      final deleteUser = await _authService.deleteUser(
        userId: userDetails.id ?? '',
      );
      if (deleteUser == true) {
        final authController = Get.find<AuthController>();
        authController.logOutUser();
        isUserDeleteProgress(false);
        message('User deleted successfully');
        isUserDeleted(true);
      } else {
        isUserDeleteProgress(false);
      }
    }
  }
}
