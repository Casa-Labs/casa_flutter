import 'package:casa_flutter/utils/extensions.dart';
import 'package:casa_flutter/utils/preference_manager.dart';
import 'package:casa_flutter/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/auth_models.dart';
import '../model/service/auth_service.dart';

class AuthController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // ========= VARIABLES ========= //
  RxBool checkboxValue = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordObscured = true.obs;
  RxString message = ''.obs;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    email.clear();
    password.clear();
    isLoggedIn(false);
    isLoading(false);
    message('');
    isPasswordObscured(true);
    checkboxValue(false);
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== APIs FUNCTIONS ========== //
  Future<void> loginUserCall() async {
    if (email.text.isEmpty) {
      message('Enter email address');
      isLoggedIn(false);
    } else if (Validators.isTouchedEmailValidator!(email.text) != null) {
      message('Email address is not valid');
      isLoggedIn(false);
    } else if (password.text.isEmpty) {
      message('Enter password');
      isLoggedIn(false);
    } else {
      isLoading(true);
      LoginRequestModel loginRequestModel = LoginRequestModel(
        username: email.text,
        password: password.text,
      );

      final loginResponse = await _authService.loginUser(
        loginRequestModel: loginRequestModel,
      );

      if (loginResponse?.login != null) {
        // set token to storage
        await PreferenceManager.setData(
          PreferenceManager.token,
          loginResponse?.login?.token,
        );
        // set user details
        await PreferenceManager.setData(
          PreferenceManager.userDetails,
          loginResponse?.login?.user?.toJsonString(),
        );
        // set only user id
        await PreferenceManager.setData(
          PreferenceManager.userId,
          loginResponse?.login?.user?.id.toString(),
        );
        message('User logged in successfully');
        isLoggedIn(true);
      } else {
        isLoading(false);
      }
    }
  }

  void showPassword() {
    if (isPasswordObscured()) {
      isPasswordObscured(false);
    } else {
      isPasswordObscured(true);
    }
  }

  Future<void> logOutUser() async {
    // clear user details
    await PreferenceManager.setData(
      PreferenceManager.userDetails,
      '',
    );

    // clear token
    await PreferenceManager.setData(
      PreferenceManager.token,
      '',
    );

    // clear user id
    await PreferenceManager.setData(
      PreferenceManager.userId,
      '',
    );
  }
}
