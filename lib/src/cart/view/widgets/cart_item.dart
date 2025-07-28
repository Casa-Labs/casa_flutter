import 'package:casaflutter/src/cart/view/widgets/size_guide_dialog.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../common/widgets/buttons/custom_button.dart';
import '../../controller/cart_controller.dart';
import '../../model/cart_models.dart';
import 'cart_size_selector.dart';
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
        InkWell(
          onTap: () {
            if (item.store?.id != null) {
              context.pushNamed(
                RouteNames.store,
                pathParameters: {'id': item.store?.id ?? ''},
              );
            } else {
              showToast(message: 'API Error, Store ID not found');
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(1.5),
            child: CircleAvatar(
                maxRadius: 24,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(item.store != null &&
                          item.store!.logo != null &&
                          item.store!.logo!.isNotEmpty
                      ? item.store!.logo!
                      : ImageConstants.dummyNetworkPortrait),
                )),
          ),
        ),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (item.productId != null) {
                  context.pushNamed(
                    RouteNames.productDescription,
                    pathParameters: {'id': item.productId ?? ''},
                  );
                } else {
                  showToast(message: 'API Error, Product ID not found');
                }
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Image.network(
                          item.mainImage ?? ImageConstants.dummyNetworkPortrait,
                          fit: BoxFit.fill)
                      //  Image.asset(
                      //   'assets/images/placeholder.png',
                      //   fit: BoxFit.fill,
                      // ),
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => SizeGuideDialog(),
                          );
                        },
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
                    CartSizeSelector(
                      item: item,
                      onChanged: (value) {
                        item.size = value!.size!.id;
                        item.sizeValue = value.size!.name;
                      },
                    ),
                    // _buildSizeSelector(
                    //     textTheme, item.sizeValue!, item.sizes!, context),
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
                          button: PrimaryButtons.smallBlackBG,
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
}
