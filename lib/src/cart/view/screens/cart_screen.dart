import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart';
import '../../../common/widgets/buttons/custom_button.dart';
import '../../../order/controller/order_review_controller.dart';
import '../../controller/cart_controller.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final orderReviewController = Get.find<OrderReviewController>();
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      return Scaffold(
        backgroundColor: BackgroundColor.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: cartController.cartList.isNotEmpty
              ? InkWell(
                  overlayColor:
                      WidgetStateProperty.all(ButtonColor.transparent),
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    cartController.removeAllItemFromCart();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Clear',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
          leadingWidth: 60,
          backgroundColor: BackgroundColor.white,
          actions: [
            InkWell(
              overlayColor: WidgetStateProperty.all(ButtonColor.transparent),
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                context.pushNamed(RouteNames.faq);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'FAQ',
                  style: textTheme.bodyMedium
                      ?.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
            const SizedBox(width: 5),
          ],
          title: Text(
            'My Cart',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                cartController.cartList.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 200),
                            Text(
                              'Your cart is empty!',
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: cartController.cartList.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartController.cartList[index];
                          return InkWell(
                            onTap: () {
                              context.pushNamed(
                                RouteNames.productDescription,
                                pathParameters: {
                                  'id': cartItem.item!.productId ?? ''
                                },
                              );
                            },
                            child: CartItem(
                              item: cartItem.item!,
                              // This for Deleting cart item
                              onCartItemDelete: () {
                                cartController.removeItemFromCart(cartItem.id!);
                              },
                              // This for buying cart only one item instantly
                              onBuyNow: () {
                                orderReviewController
                                    .getAllProductItem([cartItem]);
                                context.pushNamed(RouteNames.orderReview);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              // Divider(
                              //   height: 0.5,
                              //   // color: Colors.grey.shade200
                              //   color: DividerColor.grey,
                              // ),
                              // const SizedBox(height: 25),
                            ],
                          );
                        },
                      ),
                const SizedBox(height: 10),
                if (cartController.cartList.isNotEmpty)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total:',
                            style: textTheme.bodyMedium,
                          ),
                          Text(
                            ' ₹${cartController.totalPrice}',
                            style: textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 50),
                cartController.cartList.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16),
                        child: CustomPrimaryButton(
                          button: PrimaryButtons.blackBG,
                          text: "Checkout",
                          onPressed: () {
                            orderReviewController
                                .getAllProductItem(cartController.cartList());
                            context.pushNamed(RouteNames.orderReview);
                          },
                        ),
                      ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      );
    });
  }
}
