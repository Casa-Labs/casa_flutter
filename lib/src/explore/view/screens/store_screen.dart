import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/explore/controller/store_controller.dart';
import 'package:casaflutter/src/explore/model/store_model.dart';
import 'package:casaflutter/src/explore/view/widgets/banner_image.dart';
import 'package:casaflutter/utils/padding_size.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/preference_manager.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';
import '../widgets/product_card.dart';

class StoreScreen extends StatelessWidget {
  final String id;

  StoreScreen({super.key, required this.id});

  final storeCtrl = Get.put(StoreController());
  final wishController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<GetStoreInventoryResponseModel>(
          future: storeCtrl.getStoreInventoryByIdCall(storeId: id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Can't fetch store details"));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No store details available"));
            } else {
              final productList = snapshot.data?.getStoreInventory ?? [];
              return Column(
                children: [
                  BannerImage(
                    imageUrl: productList.first.product?.store?.logo ??
                        ImageConstants.dummyNetworkPortrait,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingSize.commonPadding),
                      child: Column(
                        children: [
                          // FilterRow(
                          //   brandList: exploreCtrl.brandFilter,colorList: exploreCtrl.colorFilter,productList: exploreCtrl.productFilter,sizedList: exploreCtrl.sizedFilter,
                          // ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20,
                                        childAspectRatio: 0.47,
                                        mainAxisSpacing: 15),
                                itemCount: productList.length,
                                itemBuilder: (context, index) {
                                  final product = productList[index].product;

                                  return ProductCard(
                                    name: product?.name ?? 'API Error',
                                    price: product?.price ?? 0.0,
                                    imageURL: product?.mainImage ??
                                        ImageConstants.dummyNetworkPortrait,
                                    wishlistOnPressed: () {
                                      if ((PreferenceManager.getString(
                                                  PreferenceManager.token) ??
                                              "")
                                          .isEmpty) {
                                        router.goNamed(RouteNames.signIn);
                                      } else {
                                        HapticFeedback.heavyImpact();
                                        wishController.selectedClosets.clear();
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return AddToCloset(
                                              imageUrl:
                                                  product!.mainImage.toString(),
                                              itemId: product.id.toString(),
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
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
