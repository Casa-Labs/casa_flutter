import 'package:casa_flutter/utils/color_constant.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          foregroundColor: TextColor.black,
          backgroundColor: ButtonColor.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'ADD TO CART',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
