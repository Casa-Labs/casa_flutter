import 'package:casaflutter/src/home/view/widgets/filter_chip_button.dart';
import 'package:casaflutter/src/home/view/widgets/filter_selection_dialog.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class FilterButtonRow extends StatelessWidget {
  final List<FilterButtonModel> filters;
  final VoidCallback onFilterSettingsPressed;

  const FilterButtonRow({
    super.key,
    required this.filters,
    required this.onFilterSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              icon: const Icon(Icons.tune_rounded),
              iconSize: 29,
              color: IconColor.black,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                side: const BorderSide(color: ButtonColor.black, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              onPressed: onFilterSettingsPressed,
            ),
          ),
          ...filters.map(
            (filter) => Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FilterChipButton(
                text: filter.title,
                isSelected: (filter.getSelectedValues != null &&
                    filter.getSelectedValues!().isNotEmpty),
                onPressed: () async {
                  final selectedValues = await showDialog<List<String>>(
                    context: context,
                    builder: (context) => FilterSelectionDialog(
                      showTabs: false,
                      categories: filter.list,
                      initiallySelected: filter.getSelectedValues?.call() ?? [],
                      onClear: (values) {
                        filter.onClear?.call(values);
                      },
                      onDone: (values) {
                        filter.onDone?.call(values);
                      },
                    ),
                  );

                  if (selectedValues != null) {
                    filter.onDone?.call(selectedValues);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButtonModel {
  final String title;
  final List<String> list;
  final void Function(List<String>)? onClear;
  final void Function(List<String>)? onDone;
  final List<String> Function()? getSelectedValues;

  FilterButtonModel({
    required this.title,
    required this.list,
    this.onClear,
    this.onDone,
    this.getSelectedValues,
  });
}
