import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../utils/color_constant.dart';

enum AuthButtonType {
  google,
  apple,
  email,
  signIn,
  signUp,
  send,
  verify,
  save,
  start
}

class AuthButton extends StatelessWidget {
  final AuthButtonType type;
  final VoidCallback? onPressed;

  const AuthButton({super.key, required this.type, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = ButtonColor.black;
    Color textColor = TextColor.white;
    String text = '';
    bool showIcon = false;
    IconData icon = Icons.apple;
    switch (type) {
      case AuthButtonType.google:
        backgroundColor = ButtonColor.white;
        textColor = TextColor.black;
        text = 'Continue with Google';
        showIcon = true;
        icon = TablerIcons.brand_google_filled;
        break;
      case AuthButtonType.apple:
        backgroundColor = ButtonColor.white;
        textColor = TextColor.black;
        text = 'Continue with Apple';
        showIcon = true;
        icon = TablerIcons.brand_apple_filled;
        break;
      case AuthButtonType.email:
        backgroundColor = ButtonColor.white;
        textColor = TextColor.black;
        text = 'Continue with Email';
        showIcon = true;
        icon = Icons.email;
        break;
      case AuthButtonType.signIn:
        text = 'SIGN IN';
        break;
      case AuthButtonType.signUp:
        text = 'SIGN UP';
        break;
      case AuthButtonType.send:
        text = 'SEND';
        break;
      case AuthButtonType.verify:
        text = 'VERIFY';
        break;
      case AuthButtonType.save:
        text = 'SAVE';
        break;
      case AuthButtonType.start:
        text = 'START SHOPPING';
        break;
    }

    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: backgroundColor,
          // minimumSize: size,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(color: BorderColor.black, width: 1)),
          disabledForegroundColor: ButtonColor.grey,
          disabledBackgroundColor: ButtonColor.lightGrey,
          foregroundColor: textColor,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          iconSize: 25,
          iconColor: IconColor.black,
        ),
        child: Row(
          children: [
            showIcon ? Icon(icon) : SizedBox.shrink(),
            Spacer(),
            Text(text),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
