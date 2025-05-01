import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class QuantitySelectorButton extends StatefulWidget {
  const QuantitySelectorButton(
      {super.key, required this.getQuantity, required this.count});
  final Function(int count) getQuantity;
  final int count;

  @override
  State<QuantitySelectorButton> createState() => _QuantitySelectorButtonState();
}

class _QuantitySelectorButtonState extends State<QuantitySelectorButton> {
  void _increaseCount() {
    widget.getQuantity(widget.count + 1);
  }

  void _decreaseCount() {
    if (widget.count > 1) {
      widget.getQuantity(widget.count - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        IconButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll<Color>(ButtonColor.lightGrey),
          ),
          highlightColor: ButtonColor.black.withValues(alpha: 0.3),
          onPressed: _decreaseCount,
          icon: const Icon(Icons.remove),
          color: IconColor.black,
        ),
        Container(
          width: 150,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ButtonColor.lightGrey,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            widget.count.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        IconButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll<Color>(ButtonColor.lightGrey),
          ),
          highlightColor: ButtonColor.black.withValues(alpha: 0.3),
          onPressed: _increaseCount,
          icon: const Icon(Icons.add),
          color: IconColor.black,
        ),
      ],
    );
  }
}
