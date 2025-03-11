import 'package:casa_flutter/utils/color_constant.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/widgets/buttons/custom_button.dart';
import '../../controller/cart_controller.dart';
import '../../model/cart_models.dart';
import 'counter_widget.dart';

class CartItem extends StatelessWidget {
  final ProductForCart item;
  final Function() onCartItemDelete; // This for Deleting cart item
  final Function() onBuyNow;  // This for buying cart only one item instantly
  final cartController = Get.find<CartController>();

  CartItem(
      {super.key,
      required this.item,
      required this.onCartItemDelete,
      required this.onBuyNow});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 166,
                  child: Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name!,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "₹${item.price!}",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Zara',
                      style: textTheme.bodyMedium?.copyWith(
                        color: TextColor.black54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(ImageConstants.ruler),
                        const SizedBox(width: 10),
                        Text(
                          'Size Guide',
                          style: textTheme.labelSmall?.copyWith(
                            color: TextColor.black54,
                          ),
                        ),
                      ],
                    ),
                    _buildSizeSelector(textTheme),
                    const SizedBox(height: 6),
                    CounterWidget(
                      quantity: item.quantity ?? 1,
                      onQuantityChanged: (newQuantity) {
                        item.quantity = newQuantity;
                        cartController.totalPriceCount();
                        // cartController.updateCartItem(item.id!, newQuantity);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          highlightColor: ButtonColor.yellow,
                          icon: Icon(Icons.delete),
                          onPressed: onCartItemDelete,
                        ),
                        CustomPrimaryButton(
                          button: PrimaryButtons.smallWhiteBG,
                          text: "Buy Now",
                          onPressed: onBuyNow,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Divider(height: 0.5, color: DividerColor.grey),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSizeSelector(TextTheme textTheme) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ButtonColor.lightGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Size:',
            style: textTheme.bodySmall?.copyWith(
              color: TextColor.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () {},
            highlightColor: ButtonColor.transparent,
            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          ),
        ],
      ),
    );
  }
}
