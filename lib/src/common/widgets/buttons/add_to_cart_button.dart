import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddToCartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 7),
          foregroundColor: TextColor.white,
          backgroundColor: ButtonColor.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(
              color: ButtonColor.transparent,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'ADD TO CART',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600, color: TextColor.white),
        ),
      ),
    );
  }
}
