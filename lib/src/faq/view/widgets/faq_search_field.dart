import 'package:flutter/material.dart';

class FAQSearchField extends StatelessWidget {
  const FAQSearchField(
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
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(Icons.search),
        ),
        // counterStyle: TextStyle(
        //     fontFamily: Font.gilroy,
        //     fontWeight: FontWeight.w500,
        //     color: CColor.black,
        //     fontSize: 12),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        hintText: hintText,
        isDense: true,
        // hintStyle: TextStyle(
        //     color: CColor.gray,
        //     fontFamily: Font.gilroy,
        //     fontSize: 13,
        //     fontWeight: FontWeight.w500),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
