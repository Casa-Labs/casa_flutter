import 'dart:io';

import 'package:casaflutter/src/auth/controller/auth_controller.dart';
import 'package:casaflutter/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutter/src/common/widgets/custom_text_form_field_widget.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/preference_manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Spacer(flex: 2),
                  Column(
                    children: [
                      Text(
                        'CASA',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        'Where your style journey begins',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Spacer(flex: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email Address'),
                      CustomTextFormField(
                        controller: authController.email,
                      ),
                      SizedBox(height: 20),
                      Text('Password'),
                      Obx(
                        () => CustomTextFormField(
                          controller: authController.password,
                          obscureText: authController.isPasswordObscured(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authController.showPassword();
                            },
                            icon: Icon(
                              authController.isPasswordObscured()
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => AuthButton(
                          type: AuthButtonType.signIn,
                          isLoading: authController.isLoading(),
                          onPressed: () async {
                            await authController.loginUserCall();
                            if (authController.message().isNotEmpty) {
                              showToast(
                                message: authController.message(),
                              );
                              if (authController.isLoggedIn()) {
                                if (authController.isRegistered()) {
                                  if (PreferenceManager.getBool(PreferenceManager.isFirstTime) ?? true) {
                                    router.goNamed(RouteNames.navigation, extra: true);
                                    await PreferenceManager.setData(PreferenceManager.isFirstTime, false);
                                  } else {
                                    router.goNamed(RouteNames.navigation, extra: false);
                                  }
                                } else {
                                  router.goNamed(RouteNames.personalDetails);
                                }
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            context.pushNamed(RouteNames.forgotPassword);
                          },
                          child: Text(
                            'Forgot password?',
                          ),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Text('OR'),
                  Spacer(),
                  Obx(
                    () => AuthButton(
                      type: AuthButtonType.google,
                      isLoading: authController.isGoogleSignInLoading(),
                      onPressed: () async {
                        await authController.signInWithGoogle();
                        if (authController.message().isNotEmpty) {
                          showToast(
                            message: authController.message(),
                          );
                          // if registered then navigate to home screen
                          if (authController.isRegistered()) {
                            if (authController.isGoogleLoggedIn()) {
                              if (PreferenceManager.getBool(
                                      PreferenceManager.isFirstTime) ??
                                  true) {
                                router.goNamed(RouteNames.navigation,
                                    extra: true);
                                await PreferenceManager.setData(
                                    PreferenceManager.isFirstTime, false);
                              } else {
                                router.goNamed(RouteNames.navigation,
                                    extra: false);
                              }
                            }
                          }
                          // else navigate to Add Preferences Screen
                          else if(!authController.isSocialError()){
                            // because of apple and google requirement, skipping personal detail screen
                            router.pushNamed(RouteNames.stylePreferences);
                          }
                        }
                      },
                    ),
                  ),
                  Platform.isIOS
                      ? Obx(
                          () => AuthButton(
                            type: AuthButtonType.apple,
                            isLoading: authController.isAppleSignInLoading(),
                            onPressed: () async {
                              await authController.signInWithApple();
                              if (authController.message().isNotEmpty) {
                                showToast(
                                  message: authController.message(),
                                );
                                // if registered then navigate to home screen
                                if (authController.isRegistered()) {
                                  if (authController.isAppleLoggedIn()) {
                                    if (PreferenceManager.getBool(
                                            PreferenceManager.isFirstTime) ??
                                        false) {
                                      router.goNamed(RouteNames.navigation,
                                          extra: true);
                                      await PreferenceManager.setData(
                                          PreferenceManager.isFirstTime, false);
                                    } else {
                                      router.goNamed(RouteNames.navigation,
                                          extra: false);
                                    }
                                  }
                                }
                                // else navigate to Add Preferences Screen
                                else if(!authController.isSocialError()){
                                  // because of apple and google requirement, skipping personal detail screen
                                  router.pushNamed(RouteNames.stylePreferences);
                                }
                              }
                            },
                          ),
                        )
                      : SizedBox(),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(RouteNames.signUp);
                    },
                    child: Text(
                      'New to CASA? \n Register',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('https://casashop.in/privacy');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        logg.e('Error while opening the privacy policy');
                        showToast(
                            message:
                                'Unable to open privacy policy, please visit https://casashop.in/privacy');
                      }
                    },
                    style: TextButton.styleFrom(
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                    ),
                    child: Text(
                      'By signing up, you agree to our \nTerms of Service and Privacy Policy',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
