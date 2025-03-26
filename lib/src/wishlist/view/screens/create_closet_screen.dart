import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutterapp/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:casaflutterapp/utils/padding_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/app_bar.dart';
import '../../controller/wishlist_controller.dart';

class CreateClosetScreen extends StatelessWidget {
  final bool isBottomSheet;
  const CreateClosetScreen({super.key, this.isBottomSheet = false});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Container(
            color: BackgroundColor.white,
            height: isBottomSheet ? screenHeight * 1 : null,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (isBottomSheet)
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Create a Closet',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  // fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          InkWell(
                            overlayColor: WidgetStateProperty.all(
                                ButtonColor.transparent),
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
                    )
                  else
                    CustomAppbar(title: 'Create a Closet'),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: PaddingSize.commonPadding,
                        vertical: isBottomSheet ? 5 : 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose a closet name:',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    // fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: wishlistController.closetController,
                            style: TextStyle(
                              fontSize: 12,
                              color: TextFieldColor.black,
                            ),
                            cursorColor: TextFieldColor.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 14),
                              hintText: 'e.g., jeans, hoodies',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: TextFieldColor.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: TextFieldColor.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: TextFieldColor.black)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: screenHeight * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(wishlistController
                                            .selectedImage.isNotEmpty
                                        ? wishlistController.selectedImage.value
                                        : 'https://via.placeholder.com/150'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      wishlistController.closetController.text,
                                      style: const TextStyle(
                                        color: TextColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 1,
                          ),
                          itemCount: wishlistController.imageLinks.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () {
                                      wishlistController.selectedImage.value =
                                          wishlistController.imageLinks[index];
                                    },
                                    child: ClipOval(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: ImageDecorationColor.grey200,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: wishlistController
                                              .imageLinks[index],
                                          placeholder: (context, url) =>
                                              Container(
                                            color: ImageDecorationColor.grey300,
                                          ),
                                          //     Shimmer.fromColors(
                                          //   baseColor: Colors.grey[300]!,
                                          //   highlightColor: Colors.grey[100]!,
                                          //   child: Container(
                                          //     color: Colors.white,
                                          //   ),
                                          // ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (wishlistController.selectedImage.value ==
                                    wishlistController.imageLinks[index])
                                  Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.check,
                                      weight: 4,
                                      size: 25,
                                      color: IconColor.white,
                                    ),
                                  )
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AuthButton(
                            type: AuthButtonType.cancel,
                            onPressed: () async {
                              wishlistController.closetInit();
                              context.pop();
                            }),
                        const SizedBox(height: 10),
                        AuthButton(
                            type: AuthButtonType.createCloset,
                            onPressed: () async {
                              wishlistController.addItemToCloset(
                                  closetId: wishlistController
                                      .getUserClosetList.first.id
                                      .toString(),
                                  imageUrl: wishlistController.selectedImage(),
                                  name:
                                      wishlistController.closetController.text);
                              wishlistController.closetInit();
                              context.pop();
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
