import 'package:flutter/material.dart';

class DividerTitle extends StatelessWidget {
  final String text;

  const DividerTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
