import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../../controller/auth_controller.dart';
import '../widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(
          () => Column(
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
                  CustomTextFormField(),
                  SizedBox(height: 20),
                  Text('Password'),
                  CustomTextFormField(),
                  SizedBox(height: 20),
                  Text('Re-enter Password'),
                  CustomTextFormField(),
                ],
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 5),
                  Container(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: authCtrl.checkboxValue.value,
                      onChanged: (value) {
                        authCtrl.checkboxValue.value =
                            !authCtrl.checkboxValue.value;
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
                onPressed: authCtrl.checkboxValue.value
                    ? () {
                        context.pushNamed(RouteNames.signUpDetails);
                      }
                    : null,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
