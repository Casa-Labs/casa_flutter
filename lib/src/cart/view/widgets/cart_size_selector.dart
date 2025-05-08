import 'package:casaflutter/src/cart/model/cart_models.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class CartSizeSelector extends StatelessWidget {
  const CartSizeSelector({super.key, required this.item, this.onChanged});
  final ProductForCart item;
  final ValueChanged<Sizes?>? onChanged;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 36,
      width: MediaQuery.of(context).size.width * 0.6,
      child: DropdownButtonFormField<Sizes>(
        menuMaxHeight: 200,
        style: textTheme.bodySmall?.copyWith(color: TextColor.black),
        alignment: AlignmentDirectional.bottomStart,
        borderRadius: BorderRadius.circular(15),
        isExpanded: true,
        isDense: true,
        icon: Icon(Icons.keyboard_arrow_down, color: IconColor.grey),
        dropdownColor: Theme.of(context).colorScheme.surface,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size:',
              style: textTheme.bodySmall?.copyWith(
                color: TextColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              item.sizeValue!,
              style: textTheme.bodySmall?.copyWith(
                color: TextColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: BorderColor.black)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: BorderColor.black)),
          contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        ),
        selectedItemBuilder: (context) {
          return item.sizes!.map((item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Size:',
                  style: textTheme.bodySmall?.copyWith(
                    color: TextColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item.size!.name!,
                  style: textTheme.bodySmall?.copyWith(
                    color: TextColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }).toList();
        },
        items: item.sizes?.map((item) {
          return DropdownMenuItem<Sizes>(
            value: item,
            child: Center(
              child: Text(
                item.size!.name!,
                style: textTheme.bodySmall?.copyWith(
                  color: TextColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
