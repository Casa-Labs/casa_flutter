import 'package:flutter/material.dart';

class DividerTitle extends StatelessWidget {
  final String text;

  const DividerTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Expanded(
        //   child: CustomDropDownIcon(
        //     items: exploreCtrl.brands,
        //     hintText: 'BRANDS',
        //     itemLabel: (brand) => brand.name!,
        //   ),
        // ),
        Expanded(flex: 1, child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
        Expanded(flex: 5, child: Divider()),
      ],
    );
  }
}
