import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/auth/controller/forgot_password_controller.dart';
import 'package:casaflutterapp/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_text_form_field_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final forgotPasswordController = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(flex: 2),
                    Column(
                      children: [
                        Text(
                          'Forgot Password',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 50),
                        Image.asset(ImageConstants.forgotPasswordLogo),
                      ],
                    ),
                    Spacer(flex: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please enter your email address to receive a verification code.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 25),
                        Text('Email Address'),
                        CustomTextFormField(
                          controller: forgotPasswordController.email,
                        ),
                      ],
                    ),
                    Spacer(flex: 1),
                    AuthButton(
                      type: AuthButtonType.send,
                      onPressed: () {
                        forgotPasswordController.sentOtpCall();
                        if (forgotPasswordController.message().isNotEmpty) {
                          showToast(
                            message: forgotPasswordController.message(),
                          );
                          if (forgotPasswordController.isOtpSent()) {
                            router.pushNamed(RouteNames.verifyEmail);
                          }
                        }
                      },
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
