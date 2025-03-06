import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';
import '../../../utils/font.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final TextEditingController controller;
  final Widget? suffixIcon; // Optional suffix icon
  final Function(String)? onChanged; // The onChanged callback
  final FocusNode? focusNode; // Optional focus node

  const CustomTextField({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 12.0,
    this.color = const Color.fromARGB(255, 55, 55, 55),
    this.textAlign = TextAlign.left,
    required this.controller,
    this.suffixIcon,
    this.onChanged, // Add the optional onChanged parameter
    this.focusNode, // Add the optional FocusNode parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
              ),
          textAlign: textAlign,
        ),
        SizedBox(
          height: 36,
          width: double.infinity,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            // Assign focusNode if provided
            style: TextStyle(
              fontSize: 12,
              color: TextFieldColor.black,
            ),
            cursorColor: TextFieldColor.black,
            cursorErrorColor: TextFieldColor.red,

            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(
                  color: TextFieldColor.black,
                  width: 1.2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(
                  color: TextFieldColor.black,
                  width: 1.0,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
            onChanged:
                onChanged, // Call the onChanged callback when the text changes
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final Function(String)? onChanged; // The onChanged callback

  final TextEditingController controller; // Add this

  const PasswordTextField(
      {super.key, required this.controller, this.onChanged});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        // Use widget.controller here
        style: const TextStyle(
          fontSize: 12,
          color: TextFieldColor.black,
        ),
        cursorColor: TextFieldColor.black,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(
              color: TextFieldColor.black,
              width: 1.2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(
              color: TextFieldColor.black,
              width: 1.0,
            ),
          ),
          suffixIcon: IconButton(
            highlightColor: TextFieldColor.transparent,
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
        ),
        obscureText: _isObscured,
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key,
      this.onTap,
      this.onChanged,
      this.onFieldSubmitted,
      this.hintText = "Search for something...",
      this.controller});

  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      cursorColor: TextFieldColor.black,
      controller: controller,
      style: TextStyle(
        fontFamily: Font.gilroy,
        color: TextFieldColor.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        prefixIcon: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            onFieldSubmitted?.call(controller!.text);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.search_rounded, size: 22),
          ),
        ),
        counterStyle: TextStyle(
            fontFamily: Font.gilroy,
            fontWeight: FontWeight.w500,
            color: TextFieldColor.black,
            fontSize: 12),
        filled: true,
        fillColor: TextFieldColor.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        hintText: hintText,
        isDense: true,
        hintStyle: TextStyle(
            color: TextFieldColor.grey,
            fontFamily: Font.gilroy,
            fontSize: 13,
            fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TextFieldColor.black, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TextFieldColor.black, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
