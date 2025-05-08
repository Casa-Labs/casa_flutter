import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/explore/view/widgets/divider_title.dart';
import 'package:casaflutter/src/explore/view/widgets/explore_search_bar.dart';
import 'package:casaflutter/src/explore/view/widgets/product_card.dart';
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
        body: Obx(
          () => RefreshIndicator(
            onRefresh: exploreCtrl.onRefresh,
            child: NotificationListener<ScrollNotification>(
              // TODO : Add back the pagination later by uncommenting below logic

              // onNotification: (ScrollNotification scrollInfo) {
              //   if (scrollInfo.metrics.pixels >=
              //           scrollInfo.metrics.maxScrollExtent - 100 &&
              //       !exploreCtrl.relatedProductsIsLoadingMore.value &&
              //       exploreCtrl.relatedProductsHasMore.value) {
              //     logg.d("Fetching more products...");
              //     exploreCtrl.getProductsCall();
              //   }
              //   return true;
              // },
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
                              backgroundColor:
                                  exploreCtrl.selectedIndex.value == 0
                                      ? TabBarColor.black
                                      : TabBarColor.white,
                              foregroundColor:
                                  exploreCtrl.selectedIndex.value == 0
                                      ? TabBarColor.white
                                      : TabBarColor.black,
                            ),
                            child: Text('MEN'),
                            onPressed: () async {
                              if (exploreCtrl.selectedIndex.value == 0) return;

                              exploreCtrl.selectedIndex.value = 0;
                              exploreCtrl.clothesYouMightLike.clear();
                              await exploreCtrl.getProductsCall(
                                  isInitialLoad: true);
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
                              backgroundColor:
                                  exploreCtrl.selectedIndex.value == 1
                                      ? TabBarColor.black
                                      : TabBarColor.white,
                              foregroundColor:
                                  exploreCtrl.selectedIndex.value == 1
                                      ? TabBarColor.white
                                      : TabBarColor.black,
                            ),
                            child: Text('WOMEN'),
                            onPressed: () async {
                              if (exploreCtrl.selectedIndex.value == 1) return;
                              exploreCtrl.selectedIndex.value = 1;
                              await exploreCtrl.getProductsCall(
                                  isInitialLoad: true);
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
        spacing: 35,
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
                                context.pushNamed(
                                  RouteNames.store,
                                  pathParameters: {'id': brand.id ?? ''},
                                );
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
                                context.pushNamed(
                                  RouteNames.productDescription,
                                  pathParameters: {
                                    'id': trendingProduct.id ?? ''
                                  },
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 135,
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                                  pathParameters: {
                                    'id': newArrivalProduct.id ?? ''
                                  },
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
              DividerTitle(text: 'YOU MIGHT LIKE'),
              exploreCtrl.clothesYouMightLike.isEmpty
                  ? Text('No Clothes you might like Found',
                      style: Theme.of(context).textTheme.bodyLarge)
                  : Container(
                      height: 220,
                      margin: EdgeInsets.only(top: 8, left: 8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: exploreCtrl.clothesYouMightLike.length > 10
                              ? 10
                              : exploreCtrl.clothesYouMightLike.length,
                          itemBuilder: (context, index) {
                            final product =
                                exploreCtrl.clothesYouMightLike[index];

                            return InkWell(
                              onTap: () {
                                context.pushNamed(
                                  RouteNames.productDescription,
                                  pathParameters: {'id': product?.id ?? ''},
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
                                              product?.mainImage ??
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
          Column(
            children: [
              DividerTitle(text: 'RELATED'),
              const SizedBox(height: 25),
              exploreCtrl.clothesYouMightLike.isEmpty
                  ? Text('No related clothes found',
                      style: Theme.of(context).textTheme.bodyLarge)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(() => Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20,
                                        childAspectRatio: 0.48,
                                        mainAxisSpacing: 15),
                                itemCount:
                                    exploreCtrl.clothesYouMightLike.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      exploreCtrl.clothesYouMightLike[index];
                                  return ProductCard(
                                    name: product?.name ?? 'API Error',
                                    price: product?.price ?? 0.0,
                                    imageURL: product?.mainImage ??
                                        ImageConstants.dummyNetworkPortrait,
                                    wishlistOnPressed: () {
                                      // TODO: Implement add to closet
                                    },
                                    onTap: () {
                                      context.pushNamed(
                                        RouteNames.productDescription,
                                        pathParameters: {
                                          'id': product?.id ?? ''
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              Obx(() =>
                                  exploreCtrl.relatedProductsIsLoadingMore.value
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : const SizedBox.shrink()),
                            ],
                          )),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
