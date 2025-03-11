import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final bool expands;
  final bool? enabled;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Color? fillColor;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.height,
    this.expands = false,
    this.enabled,
    this.maxLength,
    this.textInputAction = TextInputAction.unspecified,
    this.obscureText = false,
    this.onChanged,
    this.prefixIcon,
    this.fillColor,
    this.suffixIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
        enabled: enabled,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: obscureText ? 1 : null, // obscure texts can't be multi-lined
        maxLength: maxLength,
        textAlign: maxLength != null ? TextAlign.center : TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        inputFormatters: inputFormatters,
        expands: expands,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          fillColor: fillColor,
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          counter: maxLength != null ? Offstage() : null,
          enabledBorder: borderRadius != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius!),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                )
              : null,
          disabledBorder: borderRadius != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius!),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                )
              : null,
          focusedBorder: borderRadius != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius!),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                )
              : null,
        ),
        textInputAction: textInputAction,
        obscureText: obscureText,
        obscuringCharacter: '●',
        onChanged: onChanged,
      ),
    );
  }
}
