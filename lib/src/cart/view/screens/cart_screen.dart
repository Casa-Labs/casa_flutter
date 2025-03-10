import 'package:casa_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart';
import '../../../common/widgets/buttons/custom_button.dart';
import '../../controller/cart_controller.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: cartController.cartList.isNotEmpty
            ? InkWell(
                overlayColor: WidgetStateProperty.all(ButtonColor.transparent),
                splashFactory: NoSplash.splashFactory,
                onTap: () {},
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
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
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
                        final item = cartController.cartList[index];
                        return CartItem(
                          item: item,
                          totalChange: () {},
                          onDelete: () {},
                          index: index,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Divider(
                              height: 0.5,
                              // color: Colors.grey.shade200
                              color: DividerColor.grey,
                            ),
                            const SizedBox(height: 25),
                          ],
                        );
                      },
                    ),
              const SizedBox(height: 10),
              if (cartController.cartList.isNotEmpty)
                Column(
                  children: [
                    Divider(height: 0.5, color: DividerColor.grey),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Total:',
                          style: textTheme.bodyMedium,
                        ),
                        Text(
                          ' ₹20',
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
                        onPressed: () {},
                      ),
                    ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
