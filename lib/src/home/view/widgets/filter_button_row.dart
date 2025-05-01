// class FilterButtonRow extends StatelessWidget {
//   final List<FilterButtonModel> filters;
//
//   const FilterButtonRow({
//     super.key,
//     required this.filters,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 5),
//             child: IconButton(
//               icon: const Icon(Icons.tune_rounded),
//               iconSize: 27,
//               color: IconColor.black,
//               style: IconButton.styleFrom(
//                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 minimumSize: Size.zero,
//                 side: const BorderSide(color: ButtonColor.black, width: 1),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               onPressed: () {},
//             ),
//           ),
//           ...filters.map((filter) => Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: FilterChipButton(
//                   text: filter.title,
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => FilterSelectionDialog(
//                         showTabs: false,
//                         categories: filter.list,
//                         onClear: filter.onClear,
//                         onDone: filter.onDone,
//                       ),
//                     );
//                   },
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }

import 'package:casaflutterapp/src/home/view/widgets/filter_chip_button.dart';
import 'package:casaflutterapp/src/home/view/widgets/filter_selection_dialog.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class FilterButtonRow extends StatelessWidget {
  final List<FilterButtonModel> filters;

  const FilterButtonRow({
    super.key,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              icon: const Icon(Icons.tune_rounded),
              iconSize: 27,
              color: IconColor.black,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                side: const BorderSide(color: ButtonColor.black, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              onPressed: () {},
            ),
          ),
          ...filters.map((filter) => Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: FilterChipButton(
                  text: filter.selected != null
                      ? "${filter.title}: ${filter.selected}"
                      : filter.title,
                  onPressed: () async {
                    final selectedValue = await showDialog<String?>(
                      context: context,
                      builder: (context) => FilterSelectionDialog(
                        showTabs: false,
                        categories: filter.list,
                        initiallySelected: filter.selected,
                        onClear: (value) {
                          filter.selected = null;
                          filter.onClear?.call();
                          Navigator.of(context).pop(null);
                        },
                        onDone: (value) {
                          Navigator.of(context).pop(value);
                        },
                      ),
                    );

                    if (selectedValue != null) {
                      filter.selected = selectedValue;
                      filter.onDone?.call(selectedValue);
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class FilterButtonModel {
  final String title;
  final List<String> list;
  final void Function()? onClear;
  final void Function(String?)? onDone;
  String? selected;

  FilterButtonModel({
    required this.title,
    required this.list,
    this.onClear,
    this.onDone,
    this.selected,
  });
}
