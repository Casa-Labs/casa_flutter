import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class CustomDropDownMenu extends StatelessWidget {
  final List<String?> items;
  final void Function(String)? onSelected;
  final double? width;
  final String hintText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool? check;

  const CustomDropDownMenu({
    super.key,
    required this.items,
    this.onSelected,
    this.width,
    this.hintText = '',
    this.validator,
    this.initialValue,
    this.check,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 48.h,
      width: width,
      child: DropdownButtonFormField<String?>(
        isExpanded: true,
        isDense: true,
        value: initialValue,
        alignment: AlignmentDirectional.topCenter,
        validator: validator,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        dropdownColor: Theme.of(context).colorScheme.surface,
        hint: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(hintText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: TextColor.grey,
                      ) // original : display large

                  ),
            ],
          ),
        ),
        decoration: InputDecoration(
          fillColor: check == true ? BackgroundColor.white : Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: BorderColor.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: BorderColor.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: items.map((item) {
          return (DropdownMenuItem<String?>(
            value: item,
            child: Text(
              item.toString(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ));
        }).toList(),
        onChanged: (String? value) {
          if (value != null && onSelected != null) {
            onSelected!(value);
          }
        },
      ),
    );
  }
}

class CustomDropDownIcon extends StatelessWidget {
  final List<String?> items;
  final void Function(String)? onSelected;
  final double? width;
  final String hintText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool? check;
  const CustomDropDownIcon(
      {super.key,
      required this.items,
      this.onSelected,
      this.width,
      this.hintText = '',
      this.validator,
      this.initialValue,
      this.check});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 48.h,
      width: width,
      child: DropdownButtonFormField<String?>(
        isExpanded: true,
        isDense: true,
        value: initialValue,
        alignment: AlignmentDirectional.topCenter,
        validator: validator,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        dropdownColor: Theme.of(context).colorScheme.surface,
        hint: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                hintText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: TextColor.black,
                    ), // original : display large
              ),
            ],
          ),
        ),
        decoration: InputDecoration(
          fillColor: check == true ? BackgroundColor.white : Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        items: items.map((item) {
          return (DropdownMenuItem<String?>(
            value: item,
            child: Text(
              item.toString(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ));
        }).toList(),
        onChanged: (String? value) {
          if (value != null && onSelected != null) {
            onSelected!(value);
          }
        },
      ),
    );
  }
}
