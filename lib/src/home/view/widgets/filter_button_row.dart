import 'package:casaflutterapp/src/home/view/widgets/filter_chip_button.dart';
import 'package:casaflutterapp/src/home/view/widgets/filter_selection_dialog.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class FilterButtonRow extends StatelessWidget {
  const FilterButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              icon: Icon(Icons.tune_rounded),
              iconSize: 27,
              color: IconColor.black,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                side: BorderSide(color: ButtonColor.black, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              onPressed: () {},
            ),
          ),
          FilterChipButton(
            text: 'Brand',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterSelectionDialog(
                  showTabs: false, // Toggle Men/Women tab visibility
                  categories: [
                    "Topwear",
                    "Shirt",
                    "Sweatshirt",
                    "T-Shirt",
                    "Hoodie"
                  ],
                  onClear: () => print("Clear pressed"),
                  onDone: () => print("Done pressed"),
                ),
              );
            },
          ),
          FilterChipButton(
            text: 'Category',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterSelectionDialog(
                  showTabs: false, // Toggle Men/Women tab visibility
                  categories: [
                    "XXS",
                    "XS",
                    "S",
                    "M",
                    "L",
                    "XL",
                    "XXL",
                    "XXXL",
                  ],
                  onClear: () => print("Clear pressed"),
                  onDone: () => print("Done pressed"),
                ),
              );
            },
          ),
          FilterChipButton(
            text: 'Color',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterSelectionDialog(
                  showTabs: false, // Toggle Men/Women tab visibility
                  categories: [
                    "XXS",
                    "XS",
                    "S",
                    "M",
                    "L",
                    "XL",
                    "XXL",
                    "XXXL",
                  ],
                  onClear: () => print("Clear pressed"),
                  onDone: () => print("Done pressed"),
                ),
              );
            },
          ),
          FilterChipButton(
            text: 'Price',
            onPressed: () {},
          ),
          FilterChipButton(
            text: 'Size',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterSelectionDialog(
                  showTabs: false, // Toggle Men/Women tab visibility
                  categories: [
                    "XXS",
                    "XS",
                    "S",
                    "M",
                    "L",
                    "XL",
                    "XXL",
                    "XXXL",
                  ],
                  onClear: () => print("Clear pressed"),
                  onDone: () => print("Done pressed"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
