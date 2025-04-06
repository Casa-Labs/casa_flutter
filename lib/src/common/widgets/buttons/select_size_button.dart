import 'package:flutter/material.dart';
import '../../../../utils/color_constant.dart';

class SelectSizeButton extends StatelessWidget {
  const SelectSizeButton({
    super.key,
    required this.size,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  final List<String> size;
  final String selectedSize;
  final Function(String) onSizeSelected; // Callback function

  @override
  Widget build(BuildContext context) {
    final List<String> standardSizes = [
      'XXS',
      'XS',
      'S',
      'M',
      'L',
      'XL',
      'XXL'
    ];

    return Wrap(
      spacing: 10,
      children: List.generate(standardSizes.length, (index) {
        final String currentSize = standardSizes[index];
        final bool isAvailable = size.contains(currentSize);
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
                  onSizeSelected(currentSize);
                }
              : null,
          child: Text(currentSize),
        );
      }),
    );
  }
}
