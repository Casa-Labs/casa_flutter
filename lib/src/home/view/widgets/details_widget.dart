import 'package:casaflutter/src/common/widgets/buttons/select_size_button.dart';
import 'package:casaflutter/src/home/controller/home_controller.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/font.dart';
import '../../../../utils/preference_manager.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../common/widgets/buttons/add_to_cart_button.dart';
import '../../../explore/view/widgets/quantity_selector_button.dart';
import '../../model/home_models.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final List<String> size;

  const ProductDetails({super.key, required this.product, required this.size});

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
              // Pass the size as a list from API => done
              SelectSizeButton(
                size: size,
                selectedSize: logic.selectedSize.value,
                onSizeSelected: (newSize) {
                  logic.selectSize(newSize);
                },
              ),
              const SizedBox(height: 80),
              Center(
                  child: QuantitySelectorButton(
                count: product.quantity!,
                getQuantity: (count) {
                  if (count < 6) {
                    logic.quantityCount(product, count);
                  }
                },
              )),
              const SizedBox(height: 80),
              AddToCartButton(
                onPressed: () {
                  if ((PreferenceManager.getString(PreferenceManager.token) ??
                          "")
                      .isEmpty) {
                    router.goNamed(RouteNames.signIn);
                  } else {
                    cartLogin.addProductsToCart(
                        product, product.quantity!, logic.selectedSize.value);
                    logic.addToCartSwipe();
                  }
                },
              ),
              const SizedBox(height: 20),
              ProductImageGrid(productImages: product.productImages ?? []),
              const SizedBox(height: 30),
              _buildPolicyTile(
                title: 'RETURN POLICY',
                isExpanded: logic.isShowReturn,
                onTap: () => logic.changeReturnPolicy(),
                content: product.customReturnPolicy ?? AppStrings.returnPolicy,
              ),
              const SizedBox(height: 10),
              _buildPolicyTile(
                title: 'SHIPPING POLICY',
                isExpanded: logic.isShowShipping,
                onTap: () => logic.changeShippingPolicy(),
                content:
                    product.customShippingPolicy ?? AppStrings.shippingPolicy,
              ),
              const SizedBox(height: 100.0),
              // TODO : Need to redo the review section to rely on OBX
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Reviews',
              //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //             fontWeight: FontWeight.bold,
              //           ),
              //     ),
              //     ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: ButtonColor.black,
              //           foregroundColor: ButtonColor.white,
              //         ),
              //         onPressed: () {
              //           final token = PreferenceManager.getString(
              //               PreferenceManager.token);
              //           if (token == null || token.isEmpty) {
              //             context.pushNamed(RouteNames.signIn);
              //           } else {
              //             showModalBottomSheet(
              //               context: context,
              //               isScrollControlled: true,
              //               builder: (context) {
              //                 return WriteReviewWidget(
              //                   product: product,
              //                 );
              //               },
              //             ).then(
              //               (value) {
              //                 logic.update();
              //               },
              //             );
              //           }
              //         },
              //         child: Text("Write a review")),
              //   ],
              // ),
              //
              // const SizedBox(height: 10),
              // FutureBuilder<GetProductReviewModel?>(
              //   future: logic.getReviews(product.id ?? ''),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //
              //     if (snapshot.hasError) {
              //       logg.e('Error loading reviews: ${snapshot.error}');
              //
              //       return Text('No reviews yet');
              //     }
              //
              //     final reviews = snapshot.data?.getProductInteractions ?? [];
              //
              //     if (reviews.isEmpty) {
              //       return const Text('No reviews yet');
              //     }
              //
              //     return Column(
              //       children: [
              //         ListView.builder(
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           itemCount: reviews.length > 2 ? 2 : reviews.length,
              //           itemBuilder: (context, index) {
              //             final review = reviews[index];
              //             return Padding(
              //               padding: const EdgeInsets.only(bottom: 15),
              //               child: Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     padding: const EdgeInsets.all(1),
              //                     decoration: BoxDecoration(
              //                         border:
              //                             Border.all(color: ButtonColor.black),
              //                         borderRadius: BorderRadius.circular(50)),
              //                     child: CircleAvatar(
              //                       maxRadius: 28,
              //                       backgroundColor: const Color(0xFF002957),
              //                       child: Text(
              //                         review.user?.name
              //                                 ?.substring(0, 1)
              //                                 .toUpperCase() ??
              //                             "U",
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .bodyMedium!
              //                             .copyWith(color: TextColor.white),
              //                       ),
              //                     ),
              //                   ),
              //                   const SizedBox(width: 10),
              //                   Expanded(
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           review.user?.name ?? 'Anonymous',
              //                           style: Theme.of(context)
              //                               .textTheme
              //                               .bodyLarge!
              //                               .copyWith(
              //                                 fontWeight: FontWeight.bold,
              //                               ),
              //                         ),
              //                         const SizedBox(height: 5),
              //                         Row(
              //                           children: [
              //                             ...List.generate(
              //                               5,
              //                               (i) => Icon(
              //                                 Icons.star,
              //                                 size: 16,
              //                                 color: i < (review.rating ?? 0)
              //                                     ? Colors.black
              //                                     : Colors.grey,
              //                               ),
              //                             ),
              //                             const SizedBox(width: 10),
              //                             Text(
              //                               '${review.rating ?? 0}/5',
              //                               style: Theme.of(context)
              //                                   .textTheme
              //                                   .bodyMedium!
              //                                   .copyWith(
              //                                     fontWeight: FontWeight.bold,
              //                                   ),
              //                             ),
              //                           ],
              //                         ),
              //                         if (review.comment != null &&
              //                             review.comment!.isNotEmpty) ...[
              //                           const SizedBox(height: 5),
              //                           Text(
              //                             review.comment!,
              //                             style: Theme.of(context)
              //                                 .textTheme
              //                                 .bodyMedium,
              //                           ),
              //                         ],
              //                         const SizedBox(height: 5),
              //                         Text(
              //                           logic.formatTimestamp(
              //                               review.createdAt ?? 'NA'),
              //                           style: Theme.of(context)
              //                               .textTheme
              //                               .bodySmall,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              //       ],
              //     );
              //   },
              // ),
              // const SizedBox(height: 50),
            ],
          ),
        );
      });
    });
  }

  Widget _buildPolicyTile({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required String content,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.add,
                  color: Colors.white,
                ),
              ],
            ).paddingSymmetric(horizontal: 15),
            if (isExpanded) ...[
              Divider(color: Colors.white, thickness: 1),
              Text(
                content,
                style: TextStyle(
                    fontSize: 12.5,
                    color: TextColor.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: Font.gilroy),
              ).paddingSymmetric(horizontal: 15, vertical: 5),
            ],
          ],
        ),
      ),
    );
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
