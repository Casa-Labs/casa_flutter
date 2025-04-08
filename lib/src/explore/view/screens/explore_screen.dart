import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/explore/view/widgets/divider_title.dart';
import 'package:casaflutterapp/src/explore/view/widgets/explore_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/string_constant.dart';
import '../../controller/explore_controller.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final exploreCtrl = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: exploreCtrl.onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ExploreSearchBar(),
                const Divider(),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: exploreCtrl.selectedIndex.value == 0
                              ? TabBarColor.black
                              : TabBarColor.white,
                          foregroundColor: exploreCtrl.selectedIndex.value == 0
                              ? TabBarColor.white
                              : TabBarColor.black,
                        ),
                        child: Text('MEN'),
                        onPressed: () {
                          exploreCtrl.selectedIndex.value = 0;
                        },
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: exploreCtrl.selectedIndex.value == 1
                              ? TabBarColor.black
                              : TabBarColor.white,
                          foregroundColor: exploreCtrl.selectedIndex.value == 1
                              ? TabBarColor.white
                              : TabBarColor.black,
                        ),
                        child: Text('WOMEN'),
                        onPressed: () async {
                          exploreCtrl.selectedIndex.value = 1;
                          await exploreCtrl.getTrendingNowProductsCall();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                ExploreSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreCtrl = Get.find<ExploreController>();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 25,
        children: [
          const SizedBox.shrink(),
          Column(
            children: [
              DividerTitle(
                text: 'BRANDS',
              ),
              exploreCtrl.brands.isEmpty
                  ? Text('No Brands Found',
                      style: Theme.of(context).textTheme.bodyLarge)
                  : SizedBox(
                      height: 50,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: exploreCtrl.brands.length,
                          itemBuilder: (context, index) {
                            final brand = exploreCtrl.brands[index];
                            return InkWell(
                              onTap: () {
                                context.pushNamed(RouteNames.store);
                              },
                              child: Container(
                                width: 80,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(brand
                                              .logo ??
                                          ImageConstants.dummyNetworkPortrait),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          ),

          // Trending Now Column
          Column(
            children: [
              DividerTitle(
                text: 'TRENDING NOW',
              ),
              exploreCtrl.trendingProducts.isNotEmpty
                  ? Container(
                      height: 200,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: exploreCtrl.trendingProducts.length,
                          itemBuilder: (context, index) {
                            final trendingProduct =
                                exploreCtrl.trendingProducts[index];
                            return InkWell(
                              onTap: () {
                                context
                                    .pushNamed(RouteNames.productDescription);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 130,
                                    width: 100,
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              trendingProduct.mainImage ??
                                                  ImageConstants
                                                      .dummyNetworkPortrait),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      trendingProduct.name ?? 'NA',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      '\$${trendingProduct.price ?? 'NA'}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  : Text('No data available'),
            ],
          ),
          // New Arrivals Column
          Column(
            children: [
              DividerTitle(
                text: 'NEW ARRIVALS',
              ),
              exploreCtrl.newArrivalProducts.isEmpty
                  ? Text('No data available')
                  : Container(
                      height: 220,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: exploreCtrl.newArrivalProducts.length,
                          itemBuilder: (context, index) {
                            final newArrivalProduct =
                                exploreCtrl.newArrivalProducts[index];
                            return InkWell(
                              onTap: () {
                                context.pushNamed(
                                  RouteNames.productDescription,
                                  extra: newArrivalProduct,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 210,
                                    width: 100,
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              newArrivalProduct.mainImage ??
                                                  ''),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
            ],
          ),

          // Clothes you might like column
          Column(
            children: [
              DividerTitle(
                text: 'Clothes you might like',
              ),
              exploreCtrl.clothesYouMightLike.isEmpty
                  ? Text('No Clothes you might like Found',
                      style: Theme.of(context).textTheme.bodyLarge)
                  : Container(
                      height: 220,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final product =
                                exploreCtrl.clothesYouMightLike[index];

                            return InkWell(
                              onTap: () {
                                context.pushNamed(
                                  RouteNames.productDescription,
                                  // extra: newArrivalProduct,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 210,
                                    width: 100,
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              product.mainImage ??
                                                  ImageConstants
                                                      .dummyNetworkPortrait),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
            ],
          ),

          // Related Grid View
        ],
      ),
    );
  }
}
