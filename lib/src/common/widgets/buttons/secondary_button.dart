import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? capitalise;
  const SecondaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.capitalise = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          foregroundColor: ButtonColor.white,
          backgroundColor: ButtonColor.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          capitalise == true ? text.toUpperCase() : text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.surface,
              ),
        ),
      ),
    );
  }
}
