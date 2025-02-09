import 'package:casa_flutter/src/auth/view/widgets/auth_button.dart';
import 'package:casa_flutter/src/common/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                CustomTextFormField(),
                SizedBox(height: 20),
                Text('Password'),
                CustomTextFormField(),
                SizedBox(height: 20),
                AuthButton(
                    type: AuthButtonType.signIn,
                    onPressed: () {
                      context.pushNamed(RouteNames.navigation);
                    }),
                SizedBox(height: 10),
                Center(
                  child: TextButton(
                      onPressed: () {
                        context.pushNamed(RouteNames.forgotPassword);
                      },
                      child: Text('Forgot password?')),
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
                }),
            AuthButton(
                type: AuthButtonType.apple,
                onPressed: () {
                  context.pushNamed(RouteNames.navigation);
                }),
            Spacer(),
            TextButton(
                onPressed: () {
                  context.pushNamed(RouteNames.signUp);
                },
                child: Text(
                  'New to CASA? \n Register',
                  textAlign: TextAlign.center,
                )),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
