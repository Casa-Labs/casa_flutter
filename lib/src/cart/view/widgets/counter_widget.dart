import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
    this.quantity = 1, required this.onQuantityChanged,
  });

   final int quantity;
  final ValueChanged<int> onQuantityChanged;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
 late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _increaseCount() {
    setState(() {
      _quantity++;
    });
    widget.onQuantityChanged(_quantity); // Notify parent
  }

  void _decreaseCount() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
      widget.onQuantityChanged(_quantity); // Notify parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ButtonColor.lightGrey,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(Icons.remove, _decreaseCount),
          const VerticalDivider(thickness: 1),
          const Spacer(),
          Text(
            _quantity.toString(),
            style: const TextStyle(fontSize: 14),
          ),
          const Spacer(),
          const VerticalDivider(
            thickness: 1,
          ),
          _buildButton(Icons.add, _increaseCount),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        overlayColor: WidgetStateProperty.all(ButtonColor.yellow),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Icon(icon, size: 14),
        ),
      ),
    );
  }
}
