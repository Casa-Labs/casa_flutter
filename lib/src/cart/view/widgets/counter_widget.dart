import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget(
      {super.key,
      required this.count,
      required this.removeTap,
      required this.addTap});

  final int count;
  final Function() removeTap;
  final Function() addTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          onTap: removeTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: const Icon(
              Icons.remove,
              size: 13,
            ),
          ),
        ),
        const VerticalDivider(thickness: 1),
        const Spacer(),
        Text(
          count.toString(), // Display the counter
          style: const TextStyle(fontSize: 14),
        ),
        const Spacer(),
        const VerticalDivider(thickness: 1),
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          onTap: addTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: const Icon(
              Icons.add,
              size: 13,
            ),
          ),
        ),
      ],
    );
  }
}
