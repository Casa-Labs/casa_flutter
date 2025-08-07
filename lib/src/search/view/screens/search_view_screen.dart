import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/common/widgets/textfields.dart';
import 'package:casaflutter/src/explore/view/widgets/product_card.dart';
import 'package:casaflutter/src/search/controller/search_view_controller.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/preference_manager.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';

class SearchViewScreen extends StatelessWidget {
  SearchViewScreen({super.key});

  final searchViewCtrl = Get.put(SearchViewController());
  final wishController = Get.find<WishlistController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(
          () => Column(
            spacing: 30,
            children: [
              CustomTextField(
                controller: searchViewCtrl.searchCtrl,
                text: '',
                focusNode: searchViewCtrl.focusNode,
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                onChanged: (value) async {
                  searchViewCtrl.onSearchChanged(value);
                },
              ),
              if (searchViewCtrl.productsList.isEmpty)
                const Text('No products found'),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.49,
                            mainAxisSpacing: 15),
                    itemCount: searchViewCtrl.productsList.length,
                    controller: searchViewCtrl.scrollController,
                    itemBuilder: (context, index) {
                      final product = searchViewCtrl.productsList[index];
                      return ProductCard(
                        name: product.name ?? 'API Error',
                        price: product.price ?? 0.0,
                        imageURL: product.mainImage ??
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
                                  imageUrl: product.mainImage.toString(),
                                  itemId: product.id.toString(),
                                );
                              },
                            );
                          }
                        },
                        onTap: () {
                          context.pushNamed(
                            RouteNames.productDescription,
                            pathParameters: {'id': product.id ?? ''},
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
