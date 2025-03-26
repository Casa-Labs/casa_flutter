import 'package:casaflutterapp/utils/color.dart';
import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';


class ButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const ButtonWidget({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: ButtonColor.transparent,
            backgroundColor: ButtonColor.white,
            elevation: 0,
            fixedSize: const Size.fromHeight(50),
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: CColor.borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: TextColor.black,
                ),
          )),
    );
  }
}
