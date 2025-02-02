import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/text_widgets.dart';
import '../../controller/cart_controller.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: cartController.cartList.isNotEmpty
            ? InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: BodyText(
                      text: 'Clear',
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        leadingWidth: 60,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BodyText(
                text: 'FAQ',
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
        title: const BodyText(
          text: 'My Cart',
          fontSize: 21,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cartController.cartList.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      const BodyText(
                        text: 'Your cart is empty!',
                        fontSize: 16,
                      ),
                    ],
                  ))
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: cartController.cartList.length,
                    itemBuilder: (context, index) {
                      final item = cartController.cartList[index];
                      return CartItem(
                          item: item,
                          totalChange: () {},
                          onDelete: () {},
                          index: index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Divider(
                            height: 0.5,
                            color: Colors.grey.shade200,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      );
                    },
                  ),
            const SizedBox(
              height: 10,
            ),
            if (cartController.cartList.isNotEmpty)
              Column(
                children: [
                  Divider(
                    height: 0.5,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const BodyText(
                        text: 'Total:',
                        fontSize: 14,
                      ),
                      BodyText(
                        text: ' ₹20',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
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
                      button: PrimaryButtons.blueBG,
                      text: "Checkout",
                      onPressed: () {},
                    ),
                  ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
