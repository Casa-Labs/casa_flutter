import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class MandatoryTitle extends StatelessWidget {
  final String text;
  const MandatoryTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.toUpperCase(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: TextColor.black,
                ),
          ),
          TextSpan(
            text: '*',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: TextColor.lightBlue,
                ),
          ),
        ],
      ),
    );
  }
}
