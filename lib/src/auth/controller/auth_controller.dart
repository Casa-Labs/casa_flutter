import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/utils/extensions.dart';
import 'package:casaflutter/utils/preference_manager.dart';
import 'package:casaflutter/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/auth_models.dart';
import '../model/service/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // ========= CONTROLLERS ========= //
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // ========= VARIABLES ========= //
  RxBool checkboxValue = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordObscured = true.obs;
  RxBool isGoogleSignInLoading = false.obs;

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
        message('User logged com successfully');
        isLoggedIn(true);
      } else {
        isLoading(false);
      }
    }
  }

  // ========== Google Sign-In ==========
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        message("Google Sign-In cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final firebase_auth.User? user = userCredential.user;
      if (user != null) {
        print('google login ${user}');
        googleLoginCall(email:user.email! ,provider: "GOOGLE",providerId:user.uid );
      } else {
        message("Google Sign-In failed");
      }
    } catch (e) {
      message("Google Sign-In error: ${e.toString()}");
    } finally {
    }
  }

  Future<void> googleLoginCall({required String email,required String providerId,required String provider}) async {

    isGoogleSignInLoading(true);
    GoogleLoginRequestModel googleLoginRequestModel = GoogleLoginRequestModel(
      email: email,
      providerId: providerId,
      provider: provider
      );

      final googleLoginResponse = await _authService.googleLoginUser(
        googleLoginRequestModel: googleLoginRequestModel,
      );
      if (googleLoginResponse?.singleSignOn!= null) {
        // set token to storage
        await PreferenceManager.setData(
          PreferenceManager.token,
          googleLoginResponse?.singleSignOn?.token,
        );
        // set user details
        await PreferenceManager.setData(
          PreferenceManager.userDetails,
          googleLoginResponse?.singleSignOn?.user?.toJsonString(),
        );
        // set only user id
        await PreferenceManager.setData(
          PreferenceManager.userId,
          googleLoginResponse?.singleSignOn?.user?.id.toString(),
        );
        message('User logged com successfully');
        ///todo Need to fix navigation from screen
        router.goNamed(RouteNames.navigation);
        isGoogleSignInLoading(true);
      } else {
        isGoogleSignInLoading(false);
      }

  }

  void showPassword() {
    if (isPasswordObscured()) {
      isPasswordObscured(false);
    } else {
      isPasswordObscured(true);
    }
  }
  //
  // Google Sign-Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
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
