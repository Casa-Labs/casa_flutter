import 'package:casa_flutter/src/auth/controller/auth_controller.dart';
import 'package:casa_flutter/src/auth/view/widgets/auth_button.dart';
import 'package:casa_flutter/src/common/widgets/custom_text_form_field_widget.dart';
import 'package:casa_flutter/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final authController = Get.put(
    AuthController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            router.goNamed(RouteNames.navigation);
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
              AuthButton(
                type: AuthButtonType.google,
                onPressed: () {
                  context.pushNamed(RouteNames.navigation);
                },
              ),
              AuthButton(
                type: AuthButtonType.apple,
                onPressed: () {
                  context.pushNamed(RouteNames.navigation);
                },
              ),
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
    );
  }
}
