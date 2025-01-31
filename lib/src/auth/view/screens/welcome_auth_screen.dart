import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/auth/view/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/string_constant.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.authBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Spacer(flex: 13),
            // Main Text
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Text(
                          'Become a member of our casa'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: TextColor.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                        ),
                        Text(
                          'Enjoy exclusive rewards through our membership program while you shop',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: TextColor.white,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                spacing: 15,
                children: [
                  AuthButton(
                      type: AuthButtonType.google,
                      onPressed: () {
                        context.pushNamed(RouteNames.home);
                      }),
                  AuthButton(
                      type: AuthButtonType.apple,
                      onPressed: () {
                        context.pushNamed(RouteNames.home);
                      }),
                  AuthButton(
                      type: AuthButtonType.email,
                      onPressed: () {
                        context.pushNamed(RouteNames.home);
                      }),
                ],
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
