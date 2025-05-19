import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/string_constant.dart';
import '../../auth/view/widgets/auth_button.dart';
import 'share_app_dialog.dart';

class LoginFirstScreen extends StatelessWidget {
  const LoginFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 10,
        children: [
          Image.asset(ImageConstants.tutorialPenguinSeven),
          AuthButton(
            type: AuthButtonType.signIn,
            isLoading: false,
            onPressed: () async {
              router.pushNamed(RouteNames.signIn);
            },
          ),
          AuthButton(
            type: AuthButtonType.signUp,
            isLoading: false,
            onPressed: () async {
              router.pushNamed(RouteNames.signUp);
            },
          ),
          SizedBox(height: 10),
          Text('Login to enjoy the full CASA experience',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 25),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: ButtonColor.grey, width: 1), // Bottom border only
              ),
            ),
            child: ListTile(
              title: Text("Share with a Friend"),
              titleTextStyle: Theme.of(context).textTheme.bodySmall,
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ShareAppDialog(
                    appName: 'CASA',
                    iosAppLink: 'https://apps.apple.com/app',
                    androidAppLink:
                        'https://play.google.com/store/apps/details?id=com.casashop.casaflutterappapp',
                    shareMessage: 'Check out this amazing app!', // Optional
                  ),
                );
              },
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0,
              dense: true, // Else theme will be use
            ),
          ),
        ],
      ),
    );
  }
}
