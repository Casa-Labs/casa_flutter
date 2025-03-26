import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/utils.dart';
import '../../../common/widgets/textfields.dart';
import '../../controller/wishlist_controller.dart';
import 'create_closet_screen.dart';

class AddToCloset extends StatelessWidget {
  final RxSet<String> selectedClosets = <String>{}.obs;
  final String imageUrl;
  final String itemId;
  AddToCloset({
    super.key,
    required this.imageUrl,
    required this.itemId,
  }); // Assign product to class variable

  @override
  Widget build(BuildContext context) {
    final WishlistController wishController = Get.find<WishlistController>();
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        color: BackgroundColor.white,
        height: screenHeight * 0.95,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add to Closet',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          InkWell(
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                            splashFactory: NoSplash.splashFactory,
                            onTap: () => context.pop(),
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(40)),
                                child: const Icon(Icons.close)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 7),
                          height: 40,
                          decoration: BoxDecoration(
                            color: TextFieldColor.grey200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: CustomSearchBar(
                            controller: wishController.searchController,
                            hintText: "Search for a wishlist...",
                          )),
                      // Search TextField here
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: wishController.filteredWishlist.length,
                          itemBuilder: (context, index) {
                            var closetData =
                                wishController.filteredWishlist[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8),
                              child: GestureDetector(
                                onTap: () {
                                  final currentValue =
                                      selectedClosets.contains(closetData.id);
                                  if (currentValue) {
                                    selectedClosets.remove(closetData.id);
                                  } else {
                                    selectedClosets.add(closetData.id!);
                                  }
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        closetData.imageUrl!,
                                        width: 90,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      closetData.name!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Obx(() {
                                      return Checkbox(
                                        value: selectedClosets
                                            .contains(closetData.id),
                                        onChanged: (bool? value) {
                                          if (value == true) {
                                            selectedClosets.add(closetData.id!);
                                          } else {
                                            selectedClosets
                                                .remove(closetData.id);
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        checkColor: IconColor.white,
                                        activeColor: IconColor.black,
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        showClosetBottomSheet(
                            context, CreateClosetScreen(isBottomSheet: true));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(1),
                        backgroundColor: ButtonColor.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                'New closet',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: TextColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 33,
                              height: 33,
                              decoration: const BoxDecoration(
                                color: IconColor.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add,
                                  size: 24, color: IconColor.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        for (String closet in selectedClosets) {
                          wishController.saveItemToCloset(
                            clothingItemId: closet,
                            productId: itemId,
                          );
                        }
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ButtonColor.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
