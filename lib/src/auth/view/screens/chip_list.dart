import 'package:casa_flutter/src/auth/model/chip_list_model.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class ChipList extends StatelessWidget {
  final String? heading;
  final List<ChipListModel> items;
  final ValueChanged<int>? onChipSelected;

  const ChipList({
    super.key,
    this.heading,
    required this.items,
    this.onChipSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: DividerColor.grey),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  heading!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        Wrap(
          spacing: 20,
          runSpacing: 25,
          children: items
              .map(
                (item) => ActionChip(
                  onPressed: () {
                    onChipSelected!(item.id);
                  },
                  backgroundColor:
                      item.isSelected ? Colors.black : Colors.white,
                  label: Text(
                    item.name,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: item.isSelected ? Colors.white : Colors.black,
                        ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
