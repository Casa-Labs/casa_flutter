import 'package:casaflutter/utils/color.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class SwipeAnimation extends StatelessWidget {
  final IconData? swipeIcon;
   const SwipeAnimation({super.key,this.swipeIcon});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: swipeIcon == Icons.check_rounded ?Alignment.centerRight:Alignment.centerLeft,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: /*Icon(
              swipeIcon,
              key: ValueKey(swipeIcon),
              color: swipeIcon == Icons.check_rounded ? Colors.black : CColor.closeTick,
              size: 90,
            ),*/
            CircleAvatar(
              radius: 35,
              key: ValueKey(swipeIcon),
              backgroundColor: swipeIcon == null ?CColor.transparent:swipeIcon == Icons.check_rounded ? IconColor.black : CColor.closeTick,
              child: Icon(
                swipeIcon,
                color: swipeIcon == Icons.check_rounded ? CColor.closeTick : CColor.black,
                size: 55,
              ),
            ),
          ),
        ),
      );
  }
}
