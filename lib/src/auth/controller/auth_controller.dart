import 'dart:io';

import 'package:casaflutter/utils/extensions.dart';
import 'package:casaflutter/utils/preference_manager.dart';
import 'package:casaflutter/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../model/auth_models.dart';
import '../model/service/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  RxBool isAppleSignInLoading = false.obs;
  RxBool isGoogleLoggedIn = false.obs;
  RxBool isAppleLoggedIn = false.obs;

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
    isGoogleSignInLoading(false);
    isGoogleLoggedIn(false);
    isAppleLoggedIn(false);
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

      if (loginResponse?.login != null &&
          (loginResponse?.errorMessage ?? '').isEmpty) {
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
        message(loginResponse?.errorMessage);
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
        await socialLoginCall(
          email: user.email ?? '',
          provider: "GOOGLE",
          providerId: user.uid,
        );
      } else {
        message("Google Sign-In failed");
      }
    } catch (e) {
      message("Google Sign-In error: ${e.toString()}");
    }
  }

  // ========== Apple Sign-In  ==========
  Future<void> signInWithApple() async {
    if (!Platform.isIOS) {
      message("Apple Sign-In is only available on iOS");
      return;
    }

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // Store details on first login
      String userId = credential.userIdentifier ?? "";
      String? email = credential.email;
      String? fullName = credential.givenName;
      if (email != null) {
        // Store in local storage or send to backend
        await saveUserData(userId, email, fullName);
      } else {
        // Fetch email from stored data if available
        final storedData = await getStoredUserData(userId);
        email = storedData?['email'] ?? 'No email found';
        fullName = storedData?['fullName'] ?? 'No name found';
      }
      await socialLoginCall(
        email: email ?? '',
        provider: "APPLE",
        providerId: userId,
      );

      message("Apple Sign-In successful");
    } catch (e) {
      message("Apple Sign-In failed: ${e.toString()}");
    }
  }

  Future<void> socialLoginCall({
    required String email,
    required String providerId,
    required String provider,
  }) async {
    // Determine which loading state to update
    if (provider == 'GOOGLE') {
      isGoogleSignInLoading(true);
    } else {
      isAppleSignInLoading(true);
    }

    GoogleLoginRequestModel googleLoginRequestModel = GoogleLoginRequestModel(
      email: email,
      providerId: providerId,
      provider: provider,
    );

    final googleLoginResponse = await _authService.googleLoginUser(
      googleLoginRequestModel: googleLoginRequestModel,
    );

    if (googleLoginResponse?.singleSignOn != null) {
      // Set token to storage
      await PreferenceManager.setData(
        PreferenceManager.token,
        googleLoginResponse?.singleSignOn?.token,
      );
      // Set user details
      await PreferenceManager.setData(
        PreferenceManager.userDetails,
        googleLoginResponse?.singleSignOn?.user?.toJsonString(),
      );
      // Set only user ID
      await PreferenceManager.setData(
        PreferenceManager.userId,
        googleLoginResponse?.singleSignOn?.user?.id.toString(),
      );

      if (provider == 'GOOGLE') {
        isGoogleLoggedIn(true);
        isGoogleSignInLoading(false);
      } else {
        isAppleLoggedIn(true);
        isAppleSignInLoading(false);
      }
      message('User logged in successfully');
    } else {
      isGoogleSignInLoading(false);
      isAppleSignInLoading(false);
    }
  }

  void showPassword() {
    if (isPasswordObscured()) {
      isPasswordObscured(false);
    } else {
      isPasswordObscured(true);
    }
  }

  // Google Sign-Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> logoutFromApple() async {
    final box = GetStorage();
    await box.erase(); // Clears all stored data

    message("User logged out successfully");
  }

  // Apple Sign-Out
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

Future<void> saveUserData(String userId, String email, String? fullName) async {
  // Save to local storage or backend
  final box = GetStorage();
  box.write(userId, {'email': email, 'fullName': fullName});
}

Future<Map<String, dynamic>?> getStoredUserData(String userId) async {
  final box = GetStorage();
  return box.read(userId);
}
