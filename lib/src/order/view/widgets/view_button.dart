import 'package:flutter/material.dart';

import '../../../common/widgets/text_widgets.dart';

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
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0.1,
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: const BorderSide(color: Colors.black38, width: 1),
          ),
        ),
        child: BodyText(
          text: text,
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
