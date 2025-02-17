import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class SmallButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const SmallButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: ButtonColor.transparent,
            backgroundColor: ButtonColor.white,
            elevation: 0.1,
            minimumSize: Size.zero,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(color: ButtonColor.black, width: 1),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: TextColor.black,
                  fontWeight: FontWeight.w500,
                ),
          )),
    );
  }
}
