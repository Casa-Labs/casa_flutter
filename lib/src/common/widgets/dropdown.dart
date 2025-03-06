import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_constant.dart';

enum DropdownMode { single, multiple }

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final void Function(List<String>) onSelected;
  final String label;
  final DropdownMode mode;
  final double fontSize;
  final double menufontSize;
  final bool fullSize;
  final Widget? hint;
  final double? width;

  const CustomDropDown({
    super.key,
    required this.items,
    required this.onSelected,
    required this.label,
    this.mode = DropdownMode.single,
    this.fontSize = 22,
    this.menufontSize = 22,
    this.fullSize = true,
    this.hint,
    this.width,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? dropdownValue;
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: widget.width != null ? true : false,
        hint: widget.hint ??
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.normal,
                        color: TextColor.black, // Dynamic color
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: widget.menufontSize,
                              fontWeight: FontWeight.w500,
                              color: TextColor.white, // Menu item text color
                            ),
                        overflow: TextOverflow.ellipsis,
                      )),
                ))
            .toList(),
        value: dropdownValue,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value;
          });
          widget.onSelected.call([value!]);
        },
        selectedItemBuilder: (BuildContext context) {
          return widget.items.map((String item) {
            return widget.hint ??
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        dropdownValue ?? 'Select Category',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.normal,
                              color: TextColor.black, // Dynamic color
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                      ),
                    ],
                  ),
                );
          }).toList();
        },
        buttonStyleData: ButtonStyleData(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          padding: widget.width != null
              ? null
              : const EdgeInsets.only(left: 14, right: 14),
          decoration: const BoxDecoration(
            color: ButtonColor.transparent,
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 0, // Hide default dropdown icon
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 260,
          useSafeArea: true,
          offset: Offset(0, 0),
          padding: const EdgeInsets.all(10),
          width: widget.width ?? (widget.fullSize ? Get.width : Get.width / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(207, 193, 193, 193),
                Color.fromARGB(207, 193, 193, 193),
                Color.fromARGB(209, 148, 148, 148),
                Color.fromARGB(205, 135, 135, 135),
                Color.fromARGB(205, 135, 135, 135),
                Color.fromARGB(208, 108, 108, 108),
                Color.fromARGB(207, 80, 80, 80),
                Color.fromARGB(226, 68, 67, 67),
                Color.fromARGB(230, 53, 53, 53),
                //Color.fromARGB(228, 25, 25, 25),

              ],
            ),
          ),
        ),
        menuItemStyleData:
            const MenuItemStyleData(padding: EdgeInsets.all(5), height: 60),
        onMenuStateChange: (bool isOpen) {
          setState(() {
            isDropdownOpen = isOpen;
          });
        },
      ),
    );
  }
}
