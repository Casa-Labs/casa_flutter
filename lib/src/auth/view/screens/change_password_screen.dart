import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/auth/controller/change_password_controller.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/string_constant.dart';
import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../widgets/auth_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String email;
  final bool isFromWithinApp;
  ChangePasswordScreen({
    super.key,
    required this.email,
    required this.isFromWithinApp,
  });

  final changePasswordController = Get.put(
    ChangePasswordController(),
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
                          'Create new password',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 50),
                        Image.asset(ImageConstants.newPassword),
                      ],
                    ),
                    Spacer(flex: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your New Password Must Be Different From Previously Used Password.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 25),
                        Text('New Password'),
                        Obx(
                          () => CustomTextFormField(
                            controller: changePasswordController.newPassword,
                            obscureText: changePasswordController
                                .isNewPasswordObscured(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                changePasswordController.showNewPassword();
                              },
                              icon: Icon(
                                changePasswordController.isNewPasswordObscured()
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text('Confirm Password'),
                        Obx(
                          () => CustomTextFormField(
                            controller:
                                changePasswordController.confirmPassword,
                            obscureText: changePasswordController
                                .isConfirmPasswordObscured(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                changePasswordController.showConfirmPassword();
                              },
                              icon: Icon(
                                changePasswordController
                                        .isConfirmPasswordObscured()
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Obx(
                      () => AuthButton(
                        isLoading: changePasswordController
                            .isPasswordChangeInProgress(),
                        type: AuthButtonType.save,
                        onPressed: () async {
                          await changePasswordController.changePassword(
                            email: email,
                            isFromWithinApp: isFromWithinApp,
                          );
                          if (changePasswordController.message().isNotEmpty) {
                            showToast(
                              message: changePasswordController.message(),
                            );
                            if (changePasswordController.isPasswordChanged()) {
                              if (isFromWithinApp && context.mounted) {
                                Navigator.of(context).maybePop();
                              } else {
                                router.goNamed(RouteNames.signIn);
                              }
                            }
                          }
                        },
                      ),
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
