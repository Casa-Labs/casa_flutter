import 'package:casaflutter/src/onboarding/view/widget/text_container.dart';
import 'package:flutter/material.dart';

class PositionTutorial extends StatelessWidget {
  const PositionTutorial(
      {super.key,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      required this.text,
      this.isAbove = true,
      this.horizontal = 30,
      this.data = const SizedBox(),
      this.crossAxisAlignmentSecond = CrossAxisAlignment.center,
      required this.onTap});
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final CrossAxisAlignment crossAxisAlignment;
  final CrossAxisAlignment crossAxisAlignmentSecond;
  final String text;
  final bool isAbove;
  final double horizontal;
  final Widget data;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Container(
      width: width,
      color: Colors.black.withValues(alpha: 0.6),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned(
              left: left,
              top: top,
              right: right,
              bottom: bottom,
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (isAbove)
                    Column(
                      spacing: 10,
                      crossAxisAlignment: crossAxisAlignmentSecond,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        data,
                        Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: horizontal),
                            child: Image.asset("assets/icons/point_arrow.png")
                            // child: homePage(),
                            ),
                      ],
                    ),
                  textContainer(text, context),
                  if (!isAbove)
                    Column(
                      crossAxisAlignment: crossAxisAlignmentSecond,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: horizontal),
                          child:
                              Image.asset("assets/icons/point_arrow_down.png"),
                          // child: homePage(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        data,
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
