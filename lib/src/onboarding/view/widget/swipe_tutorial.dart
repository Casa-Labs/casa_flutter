import 'package:casa_flutter/src/onboarding/view/widget/text_container.dart';
import 'package:flutter/material.dart';

class SwipeTutorial extends StatelessWidget {
  const SwipeTutorial({
    super.key,
    required this.crossAxisAlignment,
    required this.image,
    required this.text,
    required this.onTap,
  });
  final String image;
  final String text;
  final CrossAxisAlignment crossAxisAlignment;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha:0.6),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset(
                image,
              ),
            ),
            textContainer(text,context),
          ],
        ),
      ),
    );
  }
}
