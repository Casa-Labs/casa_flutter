import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/explore/controller/explore_controller.dart';
import 'package:casaflutter/src/wishlist/view/widgets/icons_widget.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:casaflutter/utils/padding_size.dart';
import 'package:casaflutter/utils/string_constant.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: PaddingSize.commonPadding),
                child: Column(
                  children: [
                    FilterRow(
                      brandList: exploreCtrl.brandFilter,colorList: exploreCtrl.colorFilter,productList: exploreCtrl.productFilter,sizedList: exploreCtrl.sizedFilter,
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
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Image.asset(
            ImageConstants.zaraBanner,
            fit: BoxFit.cover,
          ),
        ),

        IconsWidget(
          onTap: () {
            context.pop();
          },
          icon: Icons.arrow_back_ios_new,
          backColor: IconColor.white,
          iconColor: IconColor.black,
        ).paddingAll(10),
      ],
    );
  }
}
