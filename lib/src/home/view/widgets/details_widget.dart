import 'package:casaflutterapp/src/common/widgets/buttons/select_size_button.dart';
import 'package:casaflutterapp/src/home/controller/home_controller.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/font.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../common/widgets/buttons/add_to_cart_button.dart';
import '../../../explore/view/widgets/quantity_selector_button.dart';
import '../../model/home_models.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<HomeController>(builder: (logic) {
      return GetBuilder<CartController>(builder: (cartLogin) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    (product.name ?? "").toUpperCase(),
                    style: textTheme.bodyLarge?.copyWith(
                        // Custom font
                        ),
                  )),
                  const SizedBox(width: 30),
                  Text(
                    '₹ ${product.price?.toString() ?? 'NA'}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Description:',
                  style: Theme.of(context).textTheme.bodyLarge),
              product.description!.isNotEmpty
                  ? Text(
                      product.description.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    )
                  : Text(AppStrings.productDescription,
                      style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 35),
              Text('Size:', style: textTheme.bodyLarge),
              const SizedBox(height: 10),
              // TODO : Pass the size as a list from API
              SelectSizeButton(size: ["XS", "S", "M", "L", "XL"]),
              const SizedBox(height: 80),
              Center(child: QuantitySelectorButton()),
              const SizedBox(height: 80),
              AddToCartButton(
                onPressed: () {
                  cartLogin.addProductsToCart(product, logic.quantity.value);
                },
              ),

              const SizedBox(height: 20),
              // GridView.builder(
              //   shrinkWrap: true,
              //   itemCount: product.productImages!.length > 4
              //       ? 4
              //       : product.productImages!.length,
              //   physics: const NeverScrollableScrollPhysics(),
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 8,
              //       childAspectRatio: 0.85,
              //       mainAxisSpacing: 8),
              //   itemBuilder: (BuildContext context, int index) {
              //     return GestureDetector(
              //       onTap: () {},
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(20),
              //         child: Image.network(
              //           product.productImages![index],
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     );
              //   },
              // ),
              ProductImageGrid(productImages: product.productImages ?? []),
              const SizedBox(height: 50),
              const Divider(thickness: 1, color: Colors.black26),
              InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  logic.changeReturnPolicy();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RETURN POLICY',
                        style: TextStyle(
                            fontSize: 13,
                            color: TextColor.black.withValues(alpha: 0.5),
                            fontWeight: FontWeight.w700,
                            fontFamily: Font.gilroy),
                      ),
                      logic.isShowReturn
                          ? const Icon(Icons.keyboard_arrow_up_rounded,
                              size: 15, color: IconColor.black54)
                          : const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 15, color: IconColor.black54),
                    ],
                  ),
                ),
              ),
              logic.isShowReturn
                  ? Text(
                      'This product have no any return policy',
                      style: TextStyle(
                          fontSize: 12.5,
                          color: TextColor.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: Font.gilroy),
                    )
                  : const SizedBox(),
              const Divider(thickness: 1, color: Colors.black26),
              InkWell(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  logic.changeShippingPolicy();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SHIPPING POLICY',
                        style: TextStyle(
                            fontSize: 13,
                            color: TextColor.black.withValues(alpha: 0.5),
                            fontWeight: FontWeight.w700,
                            fontFamily: Font.gilroy),
                      ),
                      logic.isShowShipping
                          ? const Icon(Icons.keyboard_arrow_up_rounded,
                              size: 15, color: TextColor.black54)
                          : const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 15, color: TextColor.black54),
                    ],
                  ),
                ),
              ),
              logic.isShowShipping
                  ? Text(
                      'For order values below \$50, product charges a \$8 shipping fee.',
                      style: TextStyle(
                          fontSize: 12.5,
                          color: TextColor.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: Font.gilroy),
                    )
                  : const SizedBox(),
              const Divider(thickness: 1, color: DividerColor.grey),
              const SizedBox(height: 10),
              Text(
                'Reviews',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        border: Border.all(color: ButtonColor.black),
                        borderRadius: BorderRadius.circular(50)),
                    child: CircleAvatar(
                      maxRadius: 28,
                      backgroundColor: const Color(0xFF002957),
                      child: Text(
                        "ZARA",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: TextColor.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Steve_vora_04',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0; i < 5; i++) const Icon(Icons.star),
                          const SizedBox(width: 10),
                          Text(
                            '5/5',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'More',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      });
    });
  }
}

class ProductImageGrid extends StatelessWidget {
  final List<String> productImages;

  const ProductImageGrid({super.key, required this.productImages});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: productImages.length > 4 ? 4 : productImages.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        childAspectRatio: 0.85,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _showImageDialog(context, productImages[index]);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              productImages[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              InteractiveViewer(
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.8,
                maxScale: 4.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
