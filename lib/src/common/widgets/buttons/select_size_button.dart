import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class SelectSizeButton extends StatefulWidget {
  const SelectSizeButton({super.key, required this.size});
  final List<String> size;

  @override
  State<SelectSizeButton> createState() => _SelectSizeButtonState();
}

class _SelectSizeButtonState extends State<SelectSizeButton> {
  String? selectedSize;
  // Define all possible standard sizes
  final List<String> standardSizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      spacing: 10,
      children: List.generate(standardSizes.length, (index) {
        final String currentSize = standardSizes[index];
        final bool isAvailable = widget.size.contains(currentSize);
        final bool isSelected = selectedSize == currentSize;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: isAvailable
                ? (isSelected ? ButtonColor.black : ButtonColor.white)
                : ButtonColor.lightGrey, // Grey for unavailable sizes
            foregroundColor: isAvailable
                ? (isSelected ? ButtonColor.white : ButtonColor.black)
                : ButtonColor.grey,
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(
                color: isAvailable ? BorderColor.black : ButtonColor.grey,
                width: 0.5,
              ),
            ),
          ),
          onPressed: isAvailable
              ? () {
            setState(() {
              selectedSize = currentSize;
            });
          }
              : null, // Disable button if size is unavailable
          child: Text(currentSize),
        );
      }),
    );
  }
}
