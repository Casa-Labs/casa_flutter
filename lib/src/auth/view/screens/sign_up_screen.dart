import 'package:casa_flutter/src/auth/controller/sign_up_controller.dart';
import 'package:casa_flutter/src/common/widgets/show_toast.dart' show showToast;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final signUpController = Get.put(
    SignUpController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            signUpController.clearAllControllers();
            Navigator.of(context).maybePop();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () => Column(
              children: [
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
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Address'),
                    CustomTextFormField(
                      controller: signUpController.registeredEmail,
                    ),
                    SizedBox(height: 20),
                    Text('Password'),
                    Obx(
                      () => CustomTextFormField(
                        controller: signUpController.registeredPassword,
                        obscureText:
                            signUpController.isRegisteredPasswordObscured(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            signUpController.showRegisteredPassword();
                          },
                          icon: Icon(
                            signUpController.isRegisteredPasswordObscured()
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
                    Text('Re-enter Password'),
                    Obx(
                      () => CustomTextFormField(
                        controller: signUpController.registeredRenterPassword,
                        obscureText: signUpController
                            .isRegisteredRenterPasswordObscured(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            signUpController.showRegisteredRenterPassword();
                          },
                          icon: Icon(
                            signUpController
                                    .isRegisteredRenterPasswordObscured()
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 5),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        value: signUpController.checkboxValue.value,
                        onChanged: (value) {
                          signUpController.checkboxValue.value =
                              !signUpController.checkboxValue.value;
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Spacer(),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'I hereby declare that I accept all the terms and conditions.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20),
                AuthButton(
                  type: AuthButtonType.signUp,
                  onPressed: signUpController.checkboxValue()
                      ? () async {
                          await signUpController.registerUserCall();
                          if (signUpController.message().isNotEmpty) {
                            showToast(
                              message: signUpController.message(),
                            );
                            if (signUpController.isUserRegistered()) {
                              router.pushNamed(RouteNames.personalDetails);
                            }
                          }
                        }
                      : null,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
