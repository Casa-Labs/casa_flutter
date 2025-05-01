import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/auth/controller/forgot_password_controller.dart';
import 'package:casaflutterapp/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutterapp/src/common/widgets/custom_text_form_field_widget.dart';
import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyYourEmail extends StatelessWidget {
  VerifyYourEmail({super.key});

  final forgotPasswordController = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Verify Your Email',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Image.asset(
                ImageConstants.email,
                height: 135.0,
                width: 135.0,
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Please enter the security code sent to ${forgotPasswordController.email.text}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 50.0),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10.0,
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: CustomTextFormField(
                        borderRadius: 12.0,
                        maxLength: 1,
                        controller: forgotPasswordController.otp1,
                        obscureText: forgotPasswordController.isOtpObscured(),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                      child: CustomTextFormField(
                        borderRadius: 12.0,
                        maxLength: 1,
                        controller: forgotPasswordController.otp2,
                        obscureText: forgotPasswordController.isOtpObscured(),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                      child: CustomTextFormField(
                        borderRadius: 12.0,
                        maxLength: 1,
                        controller: forgotPasswordController.otp3,
                        obscureText: forgotPasswordController.isOtpObscured(),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                      child: CustomTextFormField(
                        borderRadius: 12.0,
                        maxLength: 1,
                        controller: forgotPasswordController.otp4,
                        obscureText: forgotPasswordController.isOtpObscured(),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        forgotPasswordController.showOtp();
                      },
                      icon: Icon(
                        forgotPasswordController.isOtpObscured()
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Resend Code',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(
                  () => AuthButton(
                    isLoading:
                        forgotPasswordController.isOtpVerificationInProgress(),
                    type: AuthButtonType.verify,
                    onPressed: () async {
                      await forgotPasswordController.verifyOtpCall();
                      if (forgotPasswordController.message().isNotEmpty) {
                        showToast(
                          message: forgotPasswordController.message(),
                        );
                        if (forgotPasswordController.isOtpVerified()) {
                          router.pushNamed(
                            RouteNames.changePassword,
                            pathParameters: {
                              'email': forgotPasswordController.email.text,
                              'isFromWithinApp': 'false',
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
