import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/utils.dart';
import '../../../common/widgets/text_widgets.dart';
import '../../../common/widgets/textfields.dart';
import '../../controller/wishlist_controller.dart';
import 'create_closet_screen.dart';

class AddToCloset extends StatelessWidget {
  final RxSet<String> selectedClosets = <String>{}.obs;
  AddToCloset({
    super.key,
  }); // Assign product to class variable

  @override
  Widget build(BuildContext context) {
    final WishlistController wishController = Get.find<WishlistController>();
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      height: screenHeight * 0.95,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BodyText(
                          text: 'Add to Closet',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                          color: Colors.grey[200],
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
                          var categoryMap =
                              wishController.filteredWishlist[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12),
                            child: GestureDetector(
                              onTap: () {
                                final currentValue =
                                    selectedClosets.contains(categoryMap.name);
                                if (currentValue) {
                                  selectedClosets.remove(categoryMap.name);
                                } else {
                                  selectedClosets.add(categoryMap.name);
                                }
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      categoryMap.imageUrl,
                                      width: 80,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    categoryMap.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Obx(() {
                                    return Checkbox(
                                      value: selectedClosets
                                          .contains(categoryMap.name),
                                      onChanged: (bool? value) {
                                        if (value == true) {
                                          selectedClosets.add(categoryMap.name);
                                        } else {
                                          selectedClosets
                                              .remove(categoryMap.name);
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Colors.black,
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
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: const BodyText(
                            text: 'New closet',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 33,
                            height: 33,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add,
                                size: 24, color: Colors.black),
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
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
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
    );
  }
}
