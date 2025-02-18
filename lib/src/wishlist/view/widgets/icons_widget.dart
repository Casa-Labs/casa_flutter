import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class IconsWidget extends StatelessWidget {
  const IconsWidget({
    super.key,
    required this.onTap,
    required this.icon,
    this.backColor = IconColor.black,
    this.iconColor = IconColor.white,
    this.size = 25,
    this.padding = 5,
  });
  final Function() onTap;
  final IconData icon;
  final Color backColor;
  final Color iconColor;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(40)),
        child: Icon(
          icon,
          color: iconColor,
          size: size,
        ),
      ),
    );
  }
}
