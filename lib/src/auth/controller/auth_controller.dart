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
  final TextEditingController registeredEmail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController registeredPassword = TextEditingController();
  final TextEditingController registeredRenterPassword =
      TextEditingController();

  // ========= VARIABLES ========= //
  RxBool checkboxValue = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isPasswordObscured = true.obs;
  RxString message = ''.obs;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    email.clear();
    password.clear();
    registeredEmail.clear();
    registeredPassword.clear();
    registeredRenterPassword.clear();
    isLoggedIn(false);
    message('');
    isPasswordObscured(true);
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
        await PreferenceManager.setData(
          PreferenceManager.userId,
          loginResponse?.login?.user?.id,
        );
        message('User logged in successfully');
        isLoggedIn(true);
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

  Future<void> registerUserCall() async {
    if (registeredEmail.text.isEmpty) {
      message('Enter email address');
      isLoggedIn(false);
    } else if (Validators.isTouchedEmailValidator!(registeredEmail.text) !=
        null) {
      message('Email address is not valid');
      isLoggedIn(false);
    } else if (registeredPassword.text.isEmpty) {
      message('Enter password');
      isLoggedIn(false);
    } else if (registeredRenterPassword.text.isEmpty) {
      message('Re-enter password');
      isLoggedIn(false);
    } else if (registeredPassword.text != registeredRenterPassword.text) {
      message('Entered password and Re-entered password are not same');
      isLoggedIn(false);
    } else {
      LoginRequestModel loginRequestModel = LoginRequestModel(
        username: registeredEmail.text,
        password: registeredPassword.text,
      );

      final loginResponse = await _authService.registerUser(
        loginRequestModel: loginRequestModel,
      );

      if (loginResponse?.register != null) {
        // set token to storage
        await PreferenceManager.setData(
          PreferenceManager.token,
          loginResponse?.register?.token,
        );
        message('User registered successfully');
        isLoggedIn(true);
      }
    }
  }
}
