import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class SwipeTutorial extends StatelessWidget {
  const SwipeTutorial({
    super.key,
    this.alignment,
    this.image,
    this.text,
    this.onTap,
    this.top,
    this.bottom,
    this.topImage,
    this.bottomImage,
    this.onSkip,
  });

  final String? image;
  final String? text;
  final AlignmentGeometry? alignment;
  final Function()? onTap;
  final Function()? onSkip;
  final double? top;
  final double? bottom;
  final double? topImage;
  final double? bottomImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 350),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Stack(
            alignment: alignment ?? Alignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      right: 30, left: 30, top: top ?? 0, bottom: bottom ?? 0),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 60),
                      Text(
                        text ?? 'swipe right on the clothes you like.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: TextColor.black,
                            fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onSkip,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('skip',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: TextColor.black)),
                            ),
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('next',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: TextColor.white,
                                      )),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: topImage ?? 0, bottom: bottomImage ?? 0),
                child: Image.asset(
                    image ?? "assets/tutorial_image/penguin_two.png"),
              )
            ],
          ),
        ));
  }
}
