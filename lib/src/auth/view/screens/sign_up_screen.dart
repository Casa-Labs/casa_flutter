import 'package:casaflutter/src/auth/controller/sign_up_controller.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart' show showToast;
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/utils.dart';
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
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email Address'),
                          CustomTextFormField(
                            controller: signUpController.registeredEmail,
                            onChanged: (value) {
                              signUpController.checkEmailValidation();
                            },
                          ),
                          SizedBox(height: 20),
                          Text('Password'),
                          Obx(
                            () => CustomTextFormField(
                              controller: signUpController.registeredPassword,
                              obscureText: signUpController
                                  .isRegisteredPasswordObscured(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  signUpController.showRegisteredPassword();
                                },
                                icon: Icon(
                                  signUpController
                                          .isRegisteredPasswordObscured()
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
                              controller:
                                  signUpController.registeredRenterPassword,
                              obscureText: signUpController
                                  .isRegisteredRenterPasswordObscured(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  signUpController
                                      .showRegisteredRenterPassword();
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
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: ElevatedButton(
                          onPressed: signUpController.isEmailValid()
                              ? () async {
                                  await signUpController
                                      .sentOtpForRegistration();
                                  if (signUpController.message().isNotEmpty) {
                                    showToast(
                                      message: signUpController.message(),
                                    );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            side: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          child: signUpController.isOtpSendingInProgress()
                              ? SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  !signUpController.isOtpSent()
                                      ? 'Send OTP'
                                      : 'Resend Code',
                                ),
                        ),
                      ),
                    ),
                    if (signUpController.isOtpSent())
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, bottom: 5.0),
                              child: Text('ENTER OTP'),
                            ),
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 10.0,
                              children: [
                                SizedBox(
                                  width: 50.0,
                                  child: CustomTextFormField(
                                    borderRadius: 12.0,
                                    maxLength: 1,
                                    controller: signUpController.otp1,
                                    obscureText:
                                        signUpController.isOtpObscured(),
                                    enabled: !signUpController.isOtpVerified(),
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
                                    controller: signUpController.otp2,
                                    obscureText:
                                        signUpController.isOtpObscured(),
                                    enabled: !signUpController.isOtpVerified(),
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
                                    controller: signUpController.otp3,
                                    obscureText:
                                        signUpController.isOtpObscured(),
                                    enabled: !signUpController.isOtpVerified(),
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
                                    controller: signUpController.otp4,
                                    obscureText:
                                        signUpController.isOtpObscured(),
                                    enabled: !signUpController.isOtpVerified(),
                                    onChanged: (value) async {
                                      if (value.isEmpty) {
                                        FocusScope.of(context).previousFocus();
                                      } else {
                                        await signUpController.verifyOtpCall();
                                        if (signUpController
                                            .message()
                                            .isNotEmpty) {
                                          showToast(
                                            message: signUpController.message(),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    signUpController.showOtp();
                                  },
                                  icon: Icon(
                                    signUpController.isOtpObscured()
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                                ),
                                if (signUpController
                                    .isOtpVerificationInProgress())
                                  SizedBox(
                                    height: 20.0,
                                    width: 20.0,
                                    child: CircularProgressIndicator(),
                                  ),
                                if (signUpController.isOtpVerified())
                                  Image.asset(
                                    ImageConstants.verify,
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Row(
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
                          SizedBox(width: 5),
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                final Uri url =
                                    Uri.parse('https://casashop.in/privacy');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  logg.e(
                                      'Error while opening the privacy policy');
                                  showToast(
                                      message:
                                          'Unable to open privacy policy, please visit https://casashop.in/privacy');
                                }
                              },
                              style: TextButton.styleFrom(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                              child: Text(
                                'I hereby agree to the Terms of Service and Privacy Policy',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          //Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    AuthButton(
                      type: AuthButtonType.signUp,
                      isLoading: signUpController.isRegistrationInProgress(),
                      onPressed: (signUpController.checkboxValue() &&
                              signUpController.isOtpVerified())
                          ? () async {
                              await signUpController.registerUserCall();
                              if (signUpController.message().isNotEmpty) {
                                showToast(
                                  message: signUpController.message(),
                                );
                                if (signUpController
                                    .isRegistrationCompleted()) {
                                  signUpController.clearAllControllers();
                                  router.pushNamed(RouteNames.personalDetails);
                                }
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
