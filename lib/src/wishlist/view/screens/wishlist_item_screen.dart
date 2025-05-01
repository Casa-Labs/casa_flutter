import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:casaflutterapp/utils/padding_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controller/wishlist_controller.dart';
import '../widgets/icons_widget.dart';

class WishlistItemScreen extends StatelessWidget {
  const WishlistItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              Container(
                height: screenHeight * .3,
                decoration: BoxDecoration(
                  color: ImageDecorationColor.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      wishlistController
                          .wishlistData[wishlistController.itemIndex.value]
                          .imageUrl!,
                    ), // Add an image URL if needed
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconsWidget(
                              onTap: () {
                                context.pop();
                              },
                              icon: Icons.arrow_back_ios_new,
                              backColor: IconColor.white,
                              iconColor: IconColor.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                wishlistController
                                    .wishlistData[
                                        wishlistController.itemIndex.value]
                                    .name!,
                                style: const TextStyle(
                                  color: TextColor.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconsWidget(
                              onTap: () {
                                wishlistController.wishItemDeletedOrNot();
                              },
                              icon: Icons.edit,
                              backColor: IconColor.black,
                              iconColor: IconColor.white,
                            ),
                          ],
                        ),
                        if (wishlistController.isWishItemDeleted.value)
                          IconsWidget(
                            onTap: () {
                              wishlistController.wishRemoveItem();
                            },
                            icon: Icons.delete,
                            backColor: IconColor.red,
                            iconColor: IconColor.white,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: PaddingSize.commonPadding, vertical: 5),
              //   child: FilterRow(
              //     brandList: wishlistController.brandFilter,
              //     colorList: wishlistController.colorFilter,
              //     productList: wishlistController.productFilter,
              //     sizedList: wishlistController.sizedFilter,
              //   ),
              // ),
              Obx(() {
                return Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingSize.commonPadding),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.55,
                      ),
                      itemCount: wishlistController.wishItemList.length,
                      itemBuilder: (context, index) {
                        var itemData =
                            wishlistController.wishItemList[index].product!;
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (wishlistController
                                    .isWishItemDeleted.value) {
                                  wishlistController.wishSelectedtem(index);
                                } else {
                                  context.pushNamed(
                                    RouteNames.productDescription,
                                    pathParameters: {'id': itemData.id ?? ''},
                                  );
                                }
                              },
                              child: Stack(
                                children: [
                                  SizedBox(
                                    child: Card(
                                      elevation: 1,
                                      color: ImageDecorationColor.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.27,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.6,
                                          child: Image.network(
                                            itemData.mainImage!,
                                            fit: BoxFit.cover,
                                          ),
                                          // Image.asset(
                                          //   ImageConstants.placeholderProduct,
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (wishlistController
                                      .isWishItemDeleted.value)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          wishlistController
                                              .wishSelectedtem(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(itemData.isSelected!
                                              ? Icons.circle
                                              : Icons
                                                  .radio_button_off_outlined),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "ZARA",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              wishlistController
                                                  .removeItemFromClothingItem(
                                                itemId: wishlistController
                                                    .wishItemList[index].id!,
                                              );
                                            },
                                            child: Icon(Icons.bookmark_rounded),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        itemData.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                      ),
                                      Text(
                                        itemData.price.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: TextColor.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
