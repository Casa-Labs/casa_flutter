import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/explore/controller/store_controller.dart';
import 'package:casaflutter/utils/padding_size.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/preference_manager.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';
import '../../../wishlist/view/widgets/icons_widget.dart';
import '../widgets/product_card.dart';

class StoreScreen extends StatelessWidget {
  final String id;
  StoreScreen({super.key, required this.id});

  final StoreController storeCtrl = Get.put(StoreController());
  final WishlistController wishController = Get.find<WishlistController>();
  final ScrollController _scrollController = ScrollController();

  void _setupScrollListener(String storeId) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !storeCtrl.isLoadingMore.value &&
          storeCtrl.hasMore.value) {
        storeCtrl.getStoreInventoryByIdCall(storeId: storeId, isInitial: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    storeCtrl.getStoreInventoryByIdCall(storeId: id, isInitial: true);
    _setupScrollListener(id);

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (storeCtrl.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (storeCtrl.storeInventory.isEmpty) {
            return const Center(child: Text("No store details available"));
          }

          final productList = storeCtrl.storeInventory;

          return Column(
            children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconsWidget(
                    onTap: () {
                      context.pop();
                    },
                    icon: Icons.arrow_back_ios_new,
                    backColor: IconColor.white,
                    iconColor: IconColor.black,
                  ).paddingOnly(top: 10,left: 10),
                ),
              ),
               Expanded(
                 flex: 2,
                 child: Align(
                   alignment: AlignmentDirectional.centerStart,
                   child: Container(
                      height: 120,
                      width: 120,
                      margin: EdgeInsetsGeometry.only(left: 8,top: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(image: CachedNetworkImageProvider(

                          productList.first.product?.store?.logo ??
                              ImageConstants.dummyNetworkPortrait,
                          // height: 130,
                        ),)
                      ),
                    ),
                 ),
               ),
            ],
          ),
              SizedBox(height: 10),
              Text(productList.first.product?.store?.name ?? "", style:
              Theme.of(context).textTheme.bodyLarge),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingSize.commonPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.47,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: productList.length +
                              (storeCtrl.isLoadingMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == productList.length &&
                                storeCtrl.isLoadingMore.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

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
                                        imageUrl: product!.mainImage.toString(),
                                        itemId: product.id.toString(),
                                      );
                                    },
                                  );
                                }
                              },
                              onTap: () {
                                context.pushNamed(
                                  RouteNames.productDescription,
                                  pathParameters: {'id': product?.id ?? ''},
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
