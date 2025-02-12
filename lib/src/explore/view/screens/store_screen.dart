import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/explore/controller/explore_controller.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/filter_row.dart';
import '../widgets/product_card.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreCtrl = Get.find<ExploreController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BannerImage(),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    FilterRow(
                      brandList: exploreCtrl.brandFilter,colorList: exploreCtrl.colorFilter,productList: exploreCtrl.productFilter,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 0.54,
                                  mainAxisSpacing: 15),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              name: 'Viscose Long Coat',
                              description: 'Long coat with a lapel collar',
                              price: 1000,
                              offerTag: '',
                              imageURL: ImageConstants.placeholderProduct,
                              index: index,
                              wishlistIcon: Icon(Icons.bookmark_border),
                              onTap: () {
                                context
                                    .pushNamed(RouteNames.productDescription);
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  const BannerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Image.asset(
        ImageConstants.zaraBanner,
        fit: BoxFit.cover,
      ),
    );
  }
}
