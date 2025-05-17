import 'package:casaflutter/src/auth/model/auth_models.dart';
import 'package:casaflutter/src/auth/model/service/auth_service.dart';
import 'package:casaflutter/utils/extensions.dart';
import 'package:casaflutter/utils/preference_manager.dart';
import 'package:casaflutter/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //
  final TextEditingController registeredEmail = TextEditingController();
  final TextEditingController registeredPassword = TextEditingController();
  final TextEditingController registeredRenterPassword =
      TextEditingController();
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();

  // ========= VARIABLES ========= //
  RxBool checkboxValue = false.obs;
  RxBool isUserRegistered = false.obs;
  RxBool isRegisteredPasswordObscured = true.obs;
  RxBool isRegisteredRenterPasswordObscured = true.obs;
  RxString message = ''.obs;
  RxBool isOtpObscured = true.obs;
  RxBool isEmailValid = false.obs;
  RxBool isOtpSendingInProgress = false.obs;
  RxBool isOtpSent = false.obs;
  RxBool isOtpVerificationInProgress = false.obs;
  RxBool isOtpVerified = false.obs;
  RxBool isRegistrationInProgress = false.obs;
  RxBool isRegistrationCompleted = false.obs;

// ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    registeredEmail.clear();
    registeredPassword.clear();
    registeredRenterPassword.clear();
    otp1.clear();
    otp2.clear();
    otp3.clear();
    otp4.clear();
    message('');
    isRegisteredPasswordObscured(true);
    isRegisteredRenterPasswordObscured(true);
    isUserRegistered(false);
    checkboxValue(false);
    isOtpSent(false);
    isOtpObscured(true);
    isOtpVerified(false);
    isEmailValid(false);
    isOtpSendingInProgress(false);
    isOtpVerificationInProgress(false);
    isRegistrationInProgress(false);
    isRegistrationCompleted(false);
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  Future<void> sentOtpForRegistration() async {
    if (registeredEmail.text.isEmpty) {
      message('Enter email address');
      isUserRegistered(false);
    } else if (Validators.isTouchedEmailValidator!(registeredEmail.text) !=
        null) {
      message('Email address is not valid');
      isUserRegistered(false);
    } else if (registeredPassword.text.isEmpty) {
      message('Enter password');
      isUserRegistered(false);
    } else if (registeredPassword.text.length < 8) {
      message('Register password length cannot be less than 8 character');
      isUserRegistered(false);
    } else if (registeredRenterPassword.text.isEmpty) {
      message('Re-enter password');
      isUserRegistered(false);
    } else if (registeredRenterPassword.text.length < 8) {
      message('Re-enter password length cannot be less than 8 character');
      isUserRegistered(false);
    } else if (registeredPassword.text != registeredRenterPassword.text) {
      message('Entered password and Re-entered password are not same');
      isUserRegistered(false);
    } else {
      isOtpSendingInProgress(true);
      final sendRegistrationOTPResponse =
          await _authService.sendRegistrationOTP(
        email: registeredEmail.text,
      );

      if (sendRegistrationOTPResponse != null) {
        isOtpSendingInProgress(false);
        message('OTP sent to entered email id');
        isOtpSent(true);
      } else {
        isOtpSendingInProgress(false);
        message('Something went wrong...');
        isOtpSent(false);
      }
    }
  }

  Future<void> verifyOtpCall() async {
    if (otp1.text.isNotEmpty &&
        otp2.text.isNotEmpty &&
        otp3.text.isNotEmpty &&
        otp4.text.isNotEmpty) {
      isOtpVerificationInProgress(true);
      final verifyRegistrationOTPResponse =
          await _authService.verifyRegistrationOTP(
        email: registeredEmail.text,
        otp: '${otp1.text}${otp2.text}${otp3.text}${otp4.text}',
      );

      if (verifyRegistrationOTPResponse != null) {
        isOtpVerificationInProgress(false);
        message('OTP verified successfully');
        isOtpVerified(true);
      } else {
        isOtpVerificationInProgress(false);
        message('Invalid or expired otp');
        isOtpVerified(false);
      }
    }
  }

  Future<void> registerUserCall() async {
    isRegistrationInProgress(true);
    LoginRequestModel loginRequestModel = LoginRequestModel(
      username: registeredEmail.text,
      password: registeredPassword.text,
      deviceID: '1234', /// devise id should be change
    );

    final registerUserResponse = await _authService.registerUser(
      loginRequestModel: loginRequestModel,
    );

    if (registerUserResponse?.register != null) {
      // set token to storage
      await PreferenceManager.setData(
        PreferenceManager.token,
        registerUserResponse?.register?.token,
      );
      // set user details
      await PreferenceManager.setData(
        PreferenceManager.userDetails,
        registerUserResponse?.register?.user?.toJsonString(),
      );
      // set only user id
      await PreferenceManager.setData(
        PreferenceManager.userId,
        registerUserResponse?.register?.user?.id.toString(),
      );
      isRegistrationInProgress(false);
      message('Few more steps and you are ready...');
      isRegistrationCompleted(true);
    } else {
      isRegistrationInProgress(false);
      message('Something went wrong...');
      isRegistrationCompleted(false);
    }
  }

  void checkEmailValidation() {
    if (registeredEmail.text.isNotEmpty &&
        Validators.isTouchedEmailValidator!(registeredEmail.text) != null) {
      isEmailValid(false);
    } else {
      isEmailValid(true);
    }
  }

  void showRegisteredPassword() {
    if (isRegisteredPasswordObscured()) {
      isRegisteredPasswordObscured(false);
    } else {
      isRegisteredPasswordObscured(true);
    }
  }

  void showRegisteredRenterPassword() {
    if (isRegisteredRenterPasswordObscured()) {
      isRegisteredRenterPasswordObscured(false);
    } else {
      isRegisteredRenterPasswordObscured(true);
    }
  }

  void showOtp() {
    if (isOtpObscured()) {
      isOtpObscured(false);
    } else {
      isOtpObscured(true);
    }
  }
}
