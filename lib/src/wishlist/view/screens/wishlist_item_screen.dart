import 'package:casa_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/filter_row.dart';
import '../../../common/widgets/text_widgets.dart';
import '../../controller/wishlist_controller.dart';
import '../widgets/icons_widget.dart';

class WishlistItemScreen extends StatelessWidget {
  const WishlistItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              Container(
                height: screenHeight * .3,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      wishlistController
                          .wishlistData[wishlistController.itemIndex.value]
                          .imageUrl,
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
                              backColor: Colors.white,
                              iconColor: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                wishlistController
                                    .wishlistData[
                                        wishlistController.itemIndex.value]
                                    .name,
                                style: const TextStyle(
                                  color: Colors.white,
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
                              backColor: Colors.black,
                              iconColor: Colors.white,
                            ),
                          ],
                        ),
                        if (wishlistController.isWishItemDeleted.value)
                          IconsWidget(
                            onTap: () {
                              wishlistController.wishRemoveItem();
                            },
                            icon: Icons.delete,
                            backColor: Colors.red,
                            iconColor: Colors.white,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: FilterRow(
                  brandList: wishlistController.brandFilter,colorList: wishlistController.colorFilter,productList: wishlistController.productFilter,
                ),
              ),
              Obx(() {
                return Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        var itemData = wishlistController.wishItemList[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .pushNamed(RouteNames.productDescription);
                              },
                              child: Stack(
                                children: [
                                  SizedBox(
                                    child: Card(
                                      elevation: 1,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          itemData.images![0].src!,
                                          fit: BoxFit.cover,
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
                                          BodyText(
                                            text: "ZARA",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                wishlistController
                                                    .wishRemoveItem();
                                              },
                                              child:
                                                  Icon(Icons.bookmark_rounded))
                                        ],
                                      ),
                                      BodyText(
                                        text: itemData.title!,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                      BodyText(
                                        text: itemData.price!,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
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
