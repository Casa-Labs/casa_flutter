import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class FilterChipButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const FilterChipButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ButtonColor.white,
        minimumSize: Size.zero,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: TextColor.black,
            ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(color: ButtonColor.black, width: 1),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(text),
          Icon(
            Icons.arrow_drop_down,
            color: IconColor.black,
            size: 20,
          ),
        ],
      ),
    );
  }
}
