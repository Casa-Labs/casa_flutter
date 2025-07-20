import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/explore/view/widgets/divider_title.dart';
import 'package:casaflutter/src/explore/view/widgets/explore_search_bar.dart';
import 'package:casaflutter/src/explore/view/widgets/product_card.dart';
import 'package:casaflutter/src/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/string_constant.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';
import '../../controller/explore_controller.dart';
import '../widgets/auto_scroll_brand.dart';

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
                    const SizedBox(height: 15),
                    ExploreSearchBar(),
                    // const SizedBox(height: 45),
                    Row(
                      children: [
                        // const SizedBox(width: 20),
                        /*Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
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
                                  await exploreCtrl
                                      .getTrendingNowProductsCall("MA");
                                  await exploreCtrl.getNewArrivalProductsCall("MA");
                                  await exploreCtrl.getProductsCall(
                                      isInitialLoad: true);
                                },
                              ),
                            ),*/
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (exploreCtrl.selectedIndex.value == 0) {
                                    return;
                                  }

                                  exploreCtrl.selectedIndex.value = 0;
                                  exploreCtrl.clothesYouMightLike.clear();
                                  await exploreCtrl
                                      .getTrendingNowProductsCall("MA");
                                  await exploreCtrl
                                      .getNewArrivalProductsCall("MA");
                                  await exploreCtrl.getProductsCall(
                                      isInitialLoad: true);
                                },
                                child: Container(
                                  height: 60,
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          exploreCtrl.selectedIndex.value == 0
                                              ? TabBarColor.black
                                              : TabBarColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 8),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    'MEN',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 20,
                                          color:
                                              exploreCtrl.selectedIndex.value ==
                                                      0
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 50.0,
                                  left: 15.0,
                                ),
                                child: Image.asset(
                                  'assets/images/men.png',
                                  height: 150,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (exploreCtrl.selectedIndex.value == 1) {
                                    return;
                                  }
                                  exploreCtrl.selectedIndex.value = 1;
                                  await exploreCtrl
                                      .getTrendingNowProductsCall("FE");
                                  await exploreCtrl
                                      .getNewArrivalProductsCall("FE");
                                  await exploreCtrl.getProductsCall(
                                      isInitialLoad: true);
                                },
                                child: Container(
                                  height: 60,
                                  margin: EdgeInsets.only(right: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          exploreCtrl.selectedIndex.value == 1
                                              ? TabBarColor.black
                                              : TabBarColor.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 8),
                                        )
                                      ]),
                                  child: Text('WOMEN',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontSize: 20,
                                              color: exploreCtrl.selectedIndex
                                                          .value ==
                                                      1
                                                  ? Colors.white
                                                  : Colors.black)),
                                ),
                              ),
                              Container(
                                // color: Colors.red,
                                padding: const EdgeInsets.only(
                                  bottom: 50.0,
                                  right: 10.0,
                                ),
                                child: Image.asset(
                                  'assets/images/women.png',
                                  height: 150,
                                ),
                              )
                            ],
                          ),
                        ),
                        /*Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
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
                              await exploreCtrl
                                  .getTrendingNowProductsCall("FE");
                              await exploreCtrl.getNewArrivalProductsCall("FE");
                              await exploreCtrl.getProductsCall(
                                  isInitialLoad: true);
                            },
                          ),
                        ),*/
                        // const SizedBox(width: 20),
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
    final wishController = Get.find<WishlistController>();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // spacing: 20,
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
                  : /*SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:
                        CarouselSlider.builder(
                          itemCount: exploreCtrl.brands.length,
                          itemBuilder: (BuildContext context, int index, int realIndex) {
                            final brand = exploreCtrl.brands[index];
                            return InkWell(
                              onTap: () {
                                context.pushNamed(
                                  RouteNames.store,
                                  pathParameters: {'id': brand.id ?? ''},
                                );
                              },
                              child: Container(
                                width: 55,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: BorderColor.black),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          brand.logo ??
                                              ImageConstants
                                                  .dummyNetworkPortrait),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,

                              viewportFraction: 1,
                              scrollDirection: Axis.horizontal),
                        ),
                        */ /*ListView.builder(
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
                                  width: 55,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: BorderColor.black),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            brand.logo ??
                                                ImageConstants
                                                    .dummyNetworkPortrait),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            }),*/ /*
                      ),
                    ),*/
                  AutoScrollBrandList(
                      brands: exploreCtrl.brands,
                      isRight: false,
                      scrollSpeed: 3),
              SizedBox(height: 10),
              AutoScrollBrandList(
                  brands: exploreCtrl.brands, isRight: true, scrollSpeed: 2),
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
                                  Expanded(
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            trendingProduct.mainImage ?? '',
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            height: 135,
                                            width: 100,
                                            margin: EdgeInsets.only(right: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              baseColor: Colors.white
                                                  .withValues(alpha: 0.5),
                                              highlightColor: Colors.black
                                                  .withValues(alpha: 0.5),
                                              child: Container(
                                                height: 135,
                                                width: 100,
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            )),
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
                                      '₹ ${trendingProduct.price ?? 'NA'}',
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
                                  Expanded(
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            newArrivalProduct.mainImage ?? '',
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            height: 210,
                                            width: 100,
                                            margin: EdgeInsets.only(right: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              baseColor: Colors.white
                                                  .withValues(alpha: 0.5),
                                              highlightColor: Colors.black
                                                  .withValues(alpha: 0.5),
                                              child: Container(
                                                height: 210,
                                                width: 100,
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            )),
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
                                  Expanded(
                                    child: CachedNetworkImage(
                                        imageUrl: product?.mainImage ?? '',
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            height: 210,
                                            width: 100,
                                            margin: EdgeInsets.only(right: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              baseColor: Colors.white
                                                  .withValues(alpha: 0.5),
                                              highlightColor: Colors.black
                                                  .withValues(alpha: 0.5),
                                              child: Container(
                                                height: 210,
                                                width: 100,
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            )),
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
              exploreCtrl.relatedProducts.isEmpty
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
                                itemCount: exploreCtrl.relatedProducts.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      exploreCtrl.relatedProducts[index];
                                  return ProductCard(
                                    name: product?.name ?? 'API Error',
                                    price: product?.price ?? 0.0,
                                    imageURL: product?.mainImage ??
                                        ImageConstants.dummyNetworkPortrait,
                                    wishlistOnPressed: () {
                                      HapticFeedback.heavyImpact();

                                      wishController.selectedClosets.clear();
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return AddToCloset(
                                            imageUrl:
                                                product!.mainImage.toString(),
                                            itemId: product.id.toString(),
                                          );
                                        },
                                      );
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
                              exploreCtrl.relatedProductsIsLoadingMore.value
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
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
