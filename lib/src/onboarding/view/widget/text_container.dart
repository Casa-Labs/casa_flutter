import 'package:flutter/material.dart';

import '../../../common/widgets/text_widgets.dart';

Widget textContainer(String text, BuildContext context) {
  return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              // fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
      ));
}
