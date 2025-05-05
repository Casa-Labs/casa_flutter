import 'package:flutter/material.dart';

class CustomImageView extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;
  const CustomImageView(
      {super.key, required this.image, this.height, this.width, this.boxFit, this.color,});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image,
      fit: BoxFit.cover,
      height: height,
      width: width,
      color: color,
    );
  }
}
