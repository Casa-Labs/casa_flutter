import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

enum PrimaryButtons {
  blackBG,
  whiteBG,
  smallWhiteBG
} // add extra button states here

class CustomPrimaryButton extends StatelessWidget {
  final PrimaryButtons button;
  final Function() onPressed;
  final String text;
  final bool isLoading;

  const CustomPrimaryButton(
      {super.key,
      required this.button,
      required this.onPressed,
        this.isLoading = false,
      required this.text});

  @override
  Widget build(BuildContext context) {
    Color textColor = ButtonColor.white;
    Color backgroundColor = ButtonColor.black;
    Size size = Size(320, 40);
    double fontSize = 18;
    Color borderColor = ButtonColor.grey;
    EdgeInsetsGeometry? padding;
    switch (button) {
      case PrimaryButtons.blackBG:
        textColor = ButtonColor.white;
        backgroundColor = ButtonColor.black;
        size = Size(320, 48);
        borderColor = ButtonColor.transparent;
        break;
      case PrimaryButtons.whiteBG:
        textColor = ButtonColor.black;
        backgroundColor = ButtonColor.white;
        size = Size(320, 48);
        borderColor = ButtonColor.transparent;
        break;
      case PrimaryButtons.smallWhiteBG:
        textColor = ButtonColor.black;
        backgroundColor = ButtonColor.white;
        size = Size(90, 25);
        fontSize = 14;
        borderColor = ButtonColor.black;
        padding = EdgeInsets.zero;
        break;
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        minimumSize: size,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: borderColor),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                    color: textColor,
                  ),
            ),
    );
  }
}
