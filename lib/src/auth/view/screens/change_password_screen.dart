import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/string_constant.dart';
import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../widgets/auth_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
              )),
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
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                      CustomTextFormField(),
                      SizedBox(height: 40),
                      Text('Confirm Password'),
                      CustomTextFormField(),
                    ],
                  ),
                  Spacer(),
                  AuthButton(
                      type: AuthButtonType.save,
                      onPressed: () {
                        context.goNamed(RouteNames.signIn);
                      }),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
