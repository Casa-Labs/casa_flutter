import 'package:casaflutter/src/common/widgets/common_app_bars.dart';
import 'package:casaflutter/src/common/widgets/login_first_screen.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/preference_manager.dart';
import '../../../common/widgets/textfields.dart';
import '../../controller/wishlist_controller.dart';
import '../widgets/icons_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishController = Get.find<WishlistController>();
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar:
          (PreferenceManager.getString(PreferenceManager.token) ?? "").isEmpty
              ? AppBar()
              : CommonAppBar(
                  title: 'My Closet',
                  showBackButton: false,
                  isBodyText: true,
                ),
      body: (PreferenceManager.getString(PreferenceManager.token) ?? "").isEmpty
          ? LoginFirstScreen()
          : SafeArea(
              child: SingleChildScrollView(
                child: Obx(() {
                  if (wishController.filteredWishlist.isEmpty &&
                      (PreferenceManager.getString(PreferenceManager.token) ??
                              "")
                          .isNotEmpty) {
                    wishController.getUserClosets();
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: TextFieldColor.grey200,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: CustomSearchBar(
                                        controller:
                                            wishController.searchController,
                                        hintText: "Search for a wishlist...",
                                      )),
                                ),
                                IconsWidget(
                                    onTap: () {
                                      wishController.getUserClosets();

                                      context
                                          .pushNamed(RouteNames.createCloset);
                                    },
                                    icon: Icons.add),
                                SizedBox(
                                  width: 5,
                                ),
                                IconsWidget(
                                    onTap: () {
                                      wishController.deleteOrNot();
                                    },
                                    icon: Icons.remove),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 130 / 85,
                              ),
                              itemCount: wishController.filteredWishlist.length,
                              itemBuilder: (context, index) {
                                var wishData =
                                    wishController.filteredWishlist[index];
                                return GestureDetector(
                                  onTap: () {
                                    // wishController.wishItemList.value =
                                    //     wishData.productList;
                                    wishController.getSavedItemsToCloset(
                                        clothingItemId: wishData.id!);
                                    wishController.itemIndex.value = index;
                                    context.pushNamed(RouteNames.wishlistItem);
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ImageDecorationColor.grey,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                wishData.imageUrl!,
                                              ), // Add an image URL if needed
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                wishData.name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      color: TextColor.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (wishController.isDeleted.value)
                                        if (wishData.name!
                                                .trim()
                                                .toLowerCase() !=
                                            AppStrings.defaultClosetName
                                                .toLowerCase())
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: IconsWidget(
                                                onTap: () {
                                                  wishController
                                                      .removeItemFromCloset(
                                                          itemId: wishData.id!);
                                                },
                                                icon: Icons.remove,
                                                size: 23,
                                                padding: 0,
                                                backColor: IconColor.red,
                                              ),
                                            ),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
    );
  }
}
