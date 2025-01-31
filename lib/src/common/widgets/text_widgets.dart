import 'package:flutter/material.dart';

import '../../../utils/font.dart';

enum TextType {
  heading,
  subheading,
  body,
}

class BodyText extends StatefulWidget {
  final String text;
  final String? fontFamily;
  final TextType type;
  final TextAlign textAlign;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final double? height;
  final List<FontVariation>? fontVariations;
  final List<Shadow>? shadows;

  const BodyText({
    super.key,
    required this.text,
    this.type = TextType.body,
    this.textAlign = TextAlign.left,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.decoration,
    this.overflow,
    this.maxLines,
    this.height,
    this.fontVariations,
    this.fontFamily,
    this.softWrap,
    this.shadows,
  });

  @override
  State<BodyText> createState() => _BodyTextState();
}

class _BodyTextState extends State<BodyText> {
  @override
  Widget build(BuildContext context) {
    // Default styles based on TextType
    TextStyle textStyle;
    switch (widget.type) {
      case TextType.heading:
        textStyle = TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: widget.color ?? Colors.black,
            fontFamily: widget.fontFamily ?? Font.gilroy,
            fontVariations: widget.fontVariations);
        break;
      case TextType.subheading:
        textStyle = TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: widget.color ?? Colors.grey[700],
            fontFamily: widget.fontFamily ?? Font.gilroy,
            fontVariations: widget.fontVariations);
        break;
      case TextType.body:
      // ignore: unreachable_switch_default
      default:
        textStyle = TextStyle(
            fontSize: widget.fontSize ?? 12.0,
            fontWeight: widget.fontWeight ?? FontWeight.normal,
            color: widget.color ?? Colors.black,
            fontFamily: widget.fontFamily ?? Font.gilroy,
            fontVariations: widget.fontVariations);
        break;
    }

    // Override styles if additional properties are provided
    textStyle = textStyle.copyWith(
        fontStyle: widget.fontStyle,
        letterSpacing: widget.letterSpacing,
        wordSpacing: widget.wordSpacing,
        decoration: widget.decoration,
        height: widget.height,
        fontFamily: widget.fontFamily ?? Font.gilroy,
        shadows: widget.shadows,
        fontVariations: widget.fontVariations);

    return Text(widget.text,
        style: textStyle,
        textAlign: widget.textAlign,
        overflow: widget.overflow,
        maxLines: widget.maxLines,
        softWrap: widget.softWrap);
  }
}
