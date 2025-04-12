import 'package:casaflutterapp/utils/color.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class SwipeAnimation extends StatelessWidget {
  final IconData? swipeIcon;

  const SwipeAnimation({super.key, this.swipeIcon});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: swipeIcon == Icons.add_shopping_cart_outlined
          ? Alignment.topCenter
          : swipeIcon == Icons.check_rounded
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: swipeIcon == Icons.add_shopping_cart_outlined ? 20 : 0),
          child: /*Icon(
              swipeIcon,
              key: ValueKey(swipeIcon),
              color: swipeIcon == Icons.check_rounded ? Colors.black : CColor.closeTick,
              size: 90,
            ),*/
              CircleAvatar(
            radius: 35,
            key: ValueKey(swipeIcon),
            backgroundColor: swipeIcon == null
                ? CColor.transparent
                : swipeIcon == Icons.add_shopping_cart_outlined
                    ? CColor.transparent
                    : swipeIcon == Icons.check_rounded
                        ? IconColor.black
                        : CColor.closeTick,
            child: Icon(
              swipeIcon,
              color: swipeIcon == Icons.add_shopping_cart_outlined
                  ? Colors.black
                  : swipeIcon == Icons.check_rounded
                      ? CColor.closeTick
                      : CColor.black,
              size:swipeIcon == Icons.add_shopping_cart_outlined ? 80 : 55,
            ),
          ),
        ),
      ),
    );
  }
}
