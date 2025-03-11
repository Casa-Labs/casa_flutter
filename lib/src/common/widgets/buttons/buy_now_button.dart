import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class BuyNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BuyNowButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ButtonColor.white,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      ),
      onPressed: onPressed,
      child: Text(
        'Buy now',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: TextColor.black,
          fontSize: 13,
          shadows: [
            Shadow(
              offset: const Offset(1.0, 1.0),
              blurRadius: 6.0,
              color: TextColor.blackWithAlphaColors2,
            ),
          ],
        ),
      ),
    );
  }
}
