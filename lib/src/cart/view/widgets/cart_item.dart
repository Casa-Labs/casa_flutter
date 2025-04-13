import 'package:casaflutterapp/src/cart/view/widgets/size_guide_dialog.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/color.dart';
import '../../../common/widgets/buttons/custom_button.dart';
import '../../controller/cart_controller.dart';
import '../../model/cart_models.dart';
import 'counter_widget.dart';

class CartItem extends StatelessWidget {
  final ProductForCart item;
  final Function() onCartItemDelete; // This for Deleting cart item
  final Function() onBuyNow; // This for buying cart only one item instantly
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 50,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: CColor.circleBoarder, width: 1)),
          child: CircleAvatar(
            maxRadius: 24,
            child: Image.network(item
                .store?.logo ??
                ImageConstants.dummyNetworkPortrait)
          ),
        ),
        SizedBox(height: 15),
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
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Image.network(item.mainImage!, fit: BoxFit.fill)
                    //  Image.asset(
                    //   'assets/images/placeholder.png',
                    //   fit: BoxFit.fill,
                    // ),
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
                            item.name ?? "API Error or NA",
                            // "hello",
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "₹${item.productPrice!}",
                          // "₹100",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.store?.name ?? "API Error or NA",
                      style: textTheme.bodyMedium?.copyWith(
                        color: TextColor.black54,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => SizeGuideDialog(),
                        );
                      },
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                      ),
                    ),
                    _buildSizeSelector(textTheme, item.sizeValue!),
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
                          highlightColor:
                              ButtonColor.black.withValues(alpha: 0.3),
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

  Widget _buildSizeSelector(TextTheme textTheme, String size) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
          Text(
            size,
            style: textTheme.bodySmall?.copyWith(
              color: TextColor.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   highlightColor: ButtonColor.transparent,
          //   icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          // ),
        ],
      ),
    );
  }
}
