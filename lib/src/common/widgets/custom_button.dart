import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

enum PrimaryButtons { blueBG, whiteBG } // add extra button states here

class CustomPrimaryButton extends StatelessWidget {
  final PrimaryButtons button;
  final Function() onPressed;
  final String text;

  const CustomPrimaryButton(
      {super.key,
      required this.button,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    Color textColor = ButtonColor.black;
    Color backgroundColor = Theme.of(context).colorScheme.secondary;
    Size size = Size(320, 40);
    Color borderColor = ButtonColor.grey;
    switch (button) {
      case PrimaryButtons.blueBG:
        textColor = ButtonColor.black;
        size = Size(320, 48);
        borderColor = ButtonColor.transparent;
        break;
      case PrimaryButtons.whiteBG:
        textColor = ButtonColor.black;
        backgroundColor = Theme.of(context).colorScheme.surface;
        size = Size(320, 48);
        borderColor = ButtonColor.transparent;
        break;
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        minimumSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: borderColor),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: textColor,
            ),
      ),
    );
  }
}
