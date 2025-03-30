import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class SelectSizeButton extends StatefulWidget {
  const SelectSizeButton({super.key, required this.size});
  final List<String> size;

  @override
  State<SelectSizeButton> createState() => _SelectSizeButtonState();
}

class _SelectSizeButtonState extends State<SelectSizeButton> {
  final List<String> sizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL'];
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: List.generate(sizes.length, (index) {
        final isSelected = selectedSize == sizes[index];

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: widget.size.contains(sizes[index])
                ? isSelected
                    ? ButtonColor.black
                    : ButtonColor.white
                : ButtonColor.lightGrey,
            foregroundColor: widget.size.contains(sizes[index])
                ? isSelected
                    ? ButtonColor.white
                    : ButtonColor.black
                : ButtonColor.grey,
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(
                  color: widget.size.contains(sizes[index])
                      ? BorderColor.black
                      : ButtonColor.grey,
                  width: 0.5),
            ),
          ),
          onPressed: () {
            setState(() {
              selectedSize = sizes[index];
            });
          },
          child: Text(
            sizes[index],
          ),
        );
      }),
    );
  }
}
