import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutterapp/src/common/widgets/buttons/buy_now_button.dart';
import 'package:casaflutterapp/src/common/widgets/common_app_bars.dart';
import 'package:casaflutterapp/src/common/widgets/custom_image_view.dart';
import 'package:casaflutterapp/src/explore/controller/explore_controller.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/padding_size.dart';
import '../../../cart/model/cart_models.dart';
import '../../../common/widgets/buttons/add_to_cart_button.dart';
import '../../../common/widgets/buttons/select_size_button.dart';
import '../widgets/care_composition_tile.dart';
import '../widgets/quantity_selector_button.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final String id;

  const ProductDescriptionScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final exploreCtrl = Get.put(ExploreController());
    return Scaffold(
      appBar: CommonAppBar(
        title: '',
      ),
      body: SafeArea(
          child: FutureBuilder<CartItem>(
        future: exploreCtrl.getProductById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Can't fetch order"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No Order available"));
          } else {
            var product = snapshot.data!.item;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(PaddingSize.commonPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(ImageConstants.avatarLogo),
                        radius: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ZARA',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text('Visit store',
                              style: Theme.of(context).textTheme.bodySmall),
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
                            imageUrl: product!.mainImage!,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.pushNamed(RouteNames.cart);
                                  },
                                  icon: const Icon(
                                      Icons.add_shopping_cart_outlined),
                                  color: IconColor.white,
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                                BuyNowButton(
                                  onPressed: () {
                                    context.pushNamed(RouteNames.orderReview);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: CustomImageView(
                          image: ImageConstants.send,
                          height: 24,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: CustomImageView(
                            image: ImageConstants.chat,
                            height: 24,
                          )),
                      Spacer(),
                      InkWell(
                        child: Icon(Icons.bookmark_border),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.name ?? 'NA',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description ?? 'NA',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Rs ${product.price}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SelectSizeButton(
                    size: [],
                  ),
                  const SizedBox(height: 20),
                  Center(child: QuantitySelectorButton()),
                  const SizedBox(height: 20),
                  AddToCartButton(
                    onPressed: () {
                      // Get.to(() => const PaymentOptionsScreen());
                      Get.snackbar('Item added to cart successfully',
                          'Not really until API integrates');
                    },
                  ),
                  const SizedBox(height: 40),
                  const CareCompositionTile(),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
