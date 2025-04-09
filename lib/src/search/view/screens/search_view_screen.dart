import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/common/widgets/textfields.dart';
import 'package:casaflutterapp/src/explore/view/widgets/product_card.dart';
import 'package:casaflutterapp/src/search/controller/search_view_controller.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SearchViewScreen extends StatelessWidget {
  SearchViewScreen({super.key});

  final searchViewCtrl = Get.put(SearchViewController());
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
                            childAspectRatio: 0.54,
                            mainAxisSpacing: 15),
                    itemCount: searchViewCtrl.productsList.length,
                    itemBuilder: (context, index) {
                      final product = searchViewCtrl.productsList[index];
                      return ProductCard(
                        name: product.name ?? 'API Error',
                        description: product.description ?? 'API Error',
                        price: product.price ?? 0.0,
                        offerTag: '',
                        imageURL: product.mainImage ??
                            ImageConstants.dummyNetworkPortrait,
                        index: index,
                        wishlistIcon: Icon(Icons.bookmark_border),
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
