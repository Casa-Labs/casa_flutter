import 'dart:io';
import 'package:casaflutterapp/src/auth/controller/auth_controller.dart';
import 'package:casaflutterapp/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutterapp/src/common/widgets/custom_text_form_field_widget.dart';
import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/preference_manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final authController = Get.put(
    AuthController(),
  );

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
                                  PreferenceManager.isFirstTime)!) {
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
                          else {
                            router.pushNamed(RouteNames.personalDetails);
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
                                        PreferenceManager.isFirstTime)!) {
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
                                else {
                                  router.pushNamed(RouteNames.personalDetails);
                                }
                              }
                            },
                          ),
                        )
                      : SizedBox(),
                  /*AuthButton(
                    type: AuthButtonType.apple,
                    onPressed: () {
                      context.pushNamed(RouteNames.navigation);
                    },
                  ),*/
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
