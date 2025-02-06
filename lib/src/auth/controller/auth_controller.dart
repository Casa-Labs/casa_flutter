import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/auth_models.dart';
import '../model/service/auth_service.dart';

class AuthController extends GetxController {
  // ========= CONTROLLERS ========= //
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // ========= VARIABLES ========= //

  bool allowLogin = false;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    email.clear();
    password.clear();
  }

  // ========== APIs FUNCTIONS ========== //
  Future<void> loginUserCall() async {
    LoginRequestModel loginReqVariables = LoginRequestModel(
      username: email.text,
      password: password.text,
    );

    await AuthService().loginUser(loginReqVariables);
  }
}
