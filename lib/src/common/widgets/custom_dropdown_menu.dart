import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item) itemLabel; // Extracts display value
  final void Function(T)? onSelected;
  final double? width;
  final String hintText;
  final FormFieldValidator<T>? validator;
  final T? initialValue;
  final bool? check;

  const CustomDropDownMenu({
    super.key,
    required this.items,
    required this.itemLabel,
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
      width: width,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        isDense: true,
        value: initialValue,
        validator: validator,
        icon: Icon(Icons.keyboard_arrow_down, color: IconColor.grey),
        dropdownColor: Theme.of(context).colorScheme.surface,
        hint: Text(
          hintText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: TextColor.grey,
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
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemLabel(item), // Extracts display text dynamically
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }).toList(),
        onChanged: (T? value) {
          if (value != null && onSelected != null) {
            onSelected!(value);
          }
        },
      ),
    );
  }
}

class CustomDropDownIcon<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item) itemLabel; // Extracts display value
  final void Function(T)? onSelected;
  final double? width;
  final String hintText;
  final String? Function(T?)? validator;
  final T? initialValue;
  final bool? check;

  const CustomDropDownIcon({
    super.key,
    required this.items,
    required this.itemLabel,
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
      width: width,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        isDense: true,
        value: initialValue,
        alignment: AlignmentDirectional.topCenter,
        validator: validator,
        icon: Icon(Icons.keyboard_arrow_down, color: IconColor.grey),
        dropdownColor: Theme.of(context).colorScheme.surface,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              hintText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: TextColor.black,
                  ),
            ),
          ],
        ),
        decoration: InputDecoration(
          fillColor: check == true ? BackgroundColor.white : Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemLabel(item), // Dynamically extract the display text
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }).toList(),
        onChanged: (T? value) {
          if (value != null && onSelected != null) {
            onSelected!(value);
          }
        },
      ),
    );
  }
}

/*
 Color.fromARGB(228, 25, 25, 25),
                Color.fromARGB(230, 53, 53, 53),
                Color.fromARGB(226, 68, 67, 67),
                Color.fromARGB(207, 80, 80, 80),
                Color.fromARGB(208, 108, 108, 108),
                Color.fromARGB(205, 135, 135, 135),
                Color.fromARGB(209, 148, 148, 148),
                Color.fromARGB(207, 193, 193, 193),*/
