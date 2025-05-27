import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class FilterChipButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isSelected;
  const FilterChipButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? ButtonColor.black : ButtonColor.white,
        minimumSize: Size.zero,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        textStyle:
            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 19),
        foregroundColor: isSelected ? ButtonColor.white : ButtonColor.black,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
            color: isSelected ? ButtonColor.white : ButtonColor.black,
            width: 1),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(text),
          Icon(
            Icons.arrow_drop_down,
            color: isSelected ? IconColor.white : IconColor.black,
            size: 20,
          ),
        ],
      ),
    );
  }
}
