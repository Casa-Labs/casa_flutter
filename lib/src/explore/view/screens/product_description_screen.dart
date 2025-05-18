import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/src/common/widgets/buttons/buy_now_button.dart';
import 'package:casaflutter/src/common/widgets/common_app_bars.dart';
import 'package:casaflutter/src/explore/controller/explore_controller.dart';
import 'package:casaflutter/src/explore/controller/product_description_controller.dart';
import 'package:casaflutter/src/explore/model/product_by_id_model.dart'
    as model;
import 'package:casaflutter/src/explore/view/widgets/divider_title.dart';
import 'package:casaflutter/src/explore/view/widgets/product_card.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:casaflutter/utils/font.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:casaflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/padding_size.dart';
import '../../../../utils/preference_manager.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../common/widgets/buttons/add_to_cart_button.dart';
import '../../../common/widgets/buttons/select_size_button.dart';
import '../../../home/controller/home_controller.dart';
import '../../../home/model/review_response.dart';
import '../../../order/controller/order_review_controller.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';
import '../widgets/product_write_review_widget.dart';
import '../widgets/quantity_selector_button.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final String id;

  ProductDescriptionScreen({super.key, required this.id});

  final productDescriptionCtrl = Get.put(ProductDescriptionController());
  final homeController = Get.find<HomeController>();
  final cartController = Get.find<CartController>();
  final orderReviewController = Get.find<OrderReviewController>();
  final wishController = Get.find<WishlistController>();
  @override
  Widget build(BuildContext context) {
    // TODO : Terrible logic of relying on explore controller but will fix it later

    final exploreCtrl = Get.put(ExploreController());
    return Scaffold(
      appBar: CommonAppBar(
        title: '',
      ),
      body: FutureBuilder<model.GetProductDetails>(
        future: exploreCtrl.getProductDetailsByIdCall(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            logg.e(snapshot.error);
            return const Center(child: Text("Can't fetch product details"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No product details available"));
          } else {
            final product = snapshot.data;
            return Obx(
              () => NotificationListener<ScrollNotification>(
                // TODO : Add back the pagination later by uncommenting below logic

                // onNotification: (ScrollNotification scrollInfo) {
                //   if (scrollInfo.metrics.pixels >=
                //           scrollInfo.metrics.maxScrollExtent - 100 &&
                //       !exploreCtrl.relatedProductsIsLoadingMore.value &&
                //       exploreCtrl.relatedProductsHasMore.value) {
                //     logg.d("Fetching more products...");
                //     productDescriptionCtrl.getRelatedProductsCall();
                //   }
                //   return true;
                // },
                child: ListView(
                  padding: const EdgeInsets.all(PaddingSize.commonPadding),
                  controller: productDescriptionCtrl.scrollController,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            product?.store?.logo ??
                                ImageConstants.dummyNetworkPortrait,
                          ),
                          radius: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product?.store?.name ?? AppStrings.productBrand,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                padding: EdgeInsets.only(right: 10, bottom: 10),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                context.pushNamed(
                                  RouteNames.store,
                                  pathParameters: {
                                    'id': product?.store?.id ?? ''
                                  },
                                );
                              },
                              child: const Text('Visit store'),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              scale: 1.82,
                              imageUrl: product?.mainImage ??
                                  ImageConstants.dummyNetworkPortrait,
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                spacing: 10,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Column(
                                      spacing: 10,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            final token =
                                                PreferenceManager.getString(
                                                    PreferenceManager.token);
                                            if (token == null ||
                                                token.isEmpty) {
                                              context
                                                  .pushNamed(RouteNames.signIn);
                                            } else {
                                              HapticFeedback.heavyImpact();

                                              cartController.addProductsToCart(
                                                  productDescriptionCtrl
                                                      .getProductData(product!),
                                                  product.quantity!,
                                                  product.sizeValue!);
                                            }
                                          },
                                          icon: Image.asset(
                                            IconConstants.cartAdd,
                                            height: 40.0,
                                            width: 40.0,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            final token =
                                                PreferenceManager.getString(
                                                    PreferenceManager.token);
                                            if (token == null ||
                                                token.isEmpty) {
                                              context
                                                  .pushNamed(RouteNames.signIn);
                                            } else {
                                              HapticFeedback.heavyImpact();
                                              wishController.selectedClosets
                                                  .clear();
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return AddToCloset(
                                                    imageUrl: product
                                                            ?.mainImage ??
                                                        ImageConstants
                                                            .dummyNetworkPortrait,
                                                    itemId:
                                                        product!.id.toString(),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Image.asset(
                                            IconConstants.bookMark,
                                            height: 40.0,
                                            width: 40.0,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            HapticFeedback.heavyImpact();
                                            Share.share(
                                                'Check out the CASA app now');
                                          },
                                          icon: Image.asset(
                                            IconConstants.forward,
                                            height: 40.0,
                                            width: 40.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  BuyNowButton(onPressed: () {
                                    final token = PreferenceManager.getString(
                                        PreferenceManager.token);
                                    if (token == null || token.isEmpty) {
                                      context.pushNamed(RouteNames.signIn);
                                    } else {
                                      HapticFeedback.heavyImpact();
                                      orderReviewController.getHomeProduct(
                                          productDescriptionCtrl
                                              .getProductData(product!),
                                          product.quantity!,
                                          product.sizeValue!);
                                      context.pushNamed(RouteNames.orderReview);
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // Row(
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: CustomImageView(
                    //         image: ImageConstants.send,
                    //         height: 24,
                    //       ),
                    //     ),
                    //     IconButton(
                    //         onPressed: () {},
                    //         icon: CustomImageView(
                    //           image: ImageConstants.chat,
                    //           height: 24,
                    //         )),
                    //     Spacer(),
                    //     InkWell(
                    //       child: Icon(Icons.bookmark_border),
                    //       onTap: () {},
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    Text(
                      product?.name ?? 'NA',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product?.description ?? 'NA',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Rs ${product?.price ?? 'API Error'}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<ProductDescriptionController>(
                      builder: (controller) {
                        return SelectSizeButton(
                          size: controller.formattedSizesList(product!),
                          selectedSize: product.sizeValue!,
                          onSizeSelected: (newSize) {
                            controller.selectSize(
                                product, newSize); // calls update()
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<ProductDescriptionController>(
                      builder: (controller) {
                        return Center(
                          child: QuantitySelectorButton(
                            count: product!.quantity!,
                            getQuantity: (count) {
                              if (count < 6) {
                                controller.quantityCount(
                                    product, count); // calls update()
                              }
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    AddToCartButton(
                      onPressed: () {
                        if ((PreferenceManager.getString(
                                    PreferenceManager.token) ??
                                "")
                            .isEmpty) {
                          router.goNamed(RouteNames.signIn);
                        } else {
                          HapticFeedback.heavyImpact();

                          cartController.addProductsToCart(
                              productDescriptionCtrl.getProductData(product!),
                              product.quantity!,
                              product.sizeValue!);
                        }
                      },
                    ),
                    const SizedBox(height: 30),

                    _buildPolicyTile(
                      title: 'RETURN POLICY',
                      isExpanded: exploreCtrl.isShowReturn,
                      onTap: () => exploreCtrl.changeReturnPolicy(),
                      content: product!.customReturnPolicy ?? 'Api Error',
                    ),
                    const SizedBox(height: 20),
                    _buildPolicyTile(
                      title: 'SHIPPING POLICY',
                      isExpanded: exploreCtrl.isShowShipping,
                      onTap: () => exploreCtrl.changeShippingPolicy(),
                      content: product.customShippingPolicy ?? 'Api Error',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ButtonColor.black,
                              foregroundColor: ButtonColor.white,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return ProductWriteReviewWidget(
                                    product: product,
                                  );
                                },
                              );
                            },
                            child: Text("Write a review")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<GetProductReviewModel?>(
                      future: homeController.getReviews(product.id ?? ''),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          logg.e('Error loading reviews: ${snapshot.error}');

                          return Text('No reviews yet');
                        }

                        final reviews =
                            snapshot.data?.getProductInteractions ?? [];

                        if (reviews.isEmpty) {
                          return const Text('No reviews yet');
                        }

                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  reviews.length > 2 ? 2 : reviews.length,
                              itemBuilder: (context, index) {
                                final review = reviews[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ButtonColor.black),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: CircleAvatar(
                                          maxRadius: 28,
                                          backgroundColor:
                                              const Color(0xFF002957),
                                          child: Text(
                                            review.user?.name
                                                    ?.substring(0, 1)
                                                    .toUpperCase() ??
                                                "U",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: TextColor.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.user?.name ?? 'Anonymous',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                ...List.generate(
                                                  5,
                                                  (i) => Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color:
                                                        i < (review.rating ?? 0)
                                                            ? Colors.black
                                                            : Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  '${review.rating ?? 0}/5',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            if (review.comment != null &&
                                                review.comment!.isNotEmpty) ...[
                                              const SizedBox(height: 5),
                                              Text(
                                                review.comment!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                            const SizedBox(height: 5),
                                            Text(
                                              homeController.formatTimestamp(
                                                  review.createdAt ?? 'NA'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            /*  if (reviews.length > 2) ...[
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Get.to(() => AllReviewsScreen(
                                  productId: product.id ?? '',
                                  productName: product.name ?? '',
                                ));
                          },
                          child: Text(
                            'More Reviews (${reviews.length - 2})',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],*/
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    // Related Grid View
                    Column(
                      children: [
                        DividerTitle(text: 'RELATED'),
                        const SizedBox(height: 25),
                        productDescriptionCtrl.relatedProducts.isEmpty
                            ? Text('No related clothes found',
                                style: Theme.of(context).textTheme.bodyLarge)
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Obx(() => Column(
                                      children: [
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 20,
                                                  childAspectRatio: 0.45,
                                                  mainAxisSpacing: 15),
                                          itemCount: productDescriptionCtrl
                                              .relatedProducts.length,
                                          itemBuilder: (context, index) {
                                            final product =
                                                productDescriptionCtrl
                                                    .relatedProducts[index];
                                            return ProductCard(
                                              name:
                                                  product?.name ?? 'API Error',
                                              price: product?.price ?? 0.0,
                                              imageURL: product?.mainImage ??
                                                  ImageConstants
                                                      .dummyNetworkPortrait,
                                              wishlistOnPressed: () {
                                                if ((PreferenceManager.getString(
                                                            PreferenceManager
                                                                .token) ??
                                                        "")
                                                    .isEmpty) {
                                                  router.goNamed(
                                                      RouteNames.signIn);
                                                } else {
                                                  HapticFeedback.heavyImpact();
                                                  wishController.selectedClosets
                                                      .clear();
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) {
                                                      return AddToCloset(
                                                        imageUrl: product!
                                                            .mainImage
                                                            .toString(),
                                                        itemId: product.id
                                                            .toString(),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              onTap: () {
                                                context.pushNamed(
                                                  RouteNames.productDescription,
                                                  pathParameters: {
                                                    'id': product?.id ?? ''
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        Obx(() => productDescriptionCtrl
                                                .relatedProductsIsLoadingMore
                                                .value
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : const SizedBox.shrink()),
                                      ],
                                    )),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildPolicyTile({
    required String? title,
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
                  title ?? 'Api Error',
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
