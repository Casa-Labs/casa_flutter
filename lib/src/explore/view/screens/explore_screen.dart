import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/common/widgets/custom_dropdown_menu.dart';
import 'package:casaflutter/src/explore/view/widgets/explore_search_bar.dart';
import 'package:casaflutter/src/explore/view/widgets/thrifts_section.dart';
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
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            initialIndex: exploreCtrl.selectedIndex.value,
            child: Column(
              children: [
                ExploreSearchBar(),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TabBar(
                    indicatorWeight: 1,
                    dividerHeight: 0,
                    splashFactory: NoSplash.splashFactory,
                    indicator: BoxDecoration(
                        color: TabBarColor.transparent,
                        border: Border.all(color: TabBarColor.transparent)),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: double.maxFinite,
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
                            child: Text('Brands'),
                            onPressed: () {
                              exploreCtrl.selectedIndex.value = 0;
                            },
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: double.maxFinite,
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
                            child: Text('Thrifts'),
                            onPressed: () async {
                              exploreCtrl.selectedIndex.value = 1;
                              await exploreCtrl.getTrendingNowProductsCall();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      BrandsSection(),
                      ThriftsSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreCtrl = Get.find<ExploreController>();

    return Obx(
      () => RefreshIndicator(
        onRefresh: exploreCtrl.onRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 25,
            children: [
              const SizedBox.shrink(),

              // Brands Column
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: CustomDropDownIcon(
                          items: exploreCtrl.brands,
                          hintText: 'BRANDS',
                          itemLabel: (brand) => brand.name!,
                        ),
                      ),
                      Expanded(flex: 2, child: Divider()),
                    ],
                  ),
                  SizedBox(
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
                                    image:
                                        CachedNetworkImageProvider(brand.logo!),
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'TRENDING NOW',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Expanded(flex: 2, child: Divider()),
                    ],
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
                                return InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        RouteNames.productDescription);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 130,
                                        width: 100,
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(ImageConstants
                                                  .splashBackground),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'GAP Bodycon Dress',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '\$20',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'NEW ARRIVALS',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Expanded(flex: 2, child: Divider()),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                    child: Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(width: 10),
                        Text(
                          'H&M Store',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                                            newArrivalProduct.mainImage ?? ''),
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

              // Shop By Category Row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropDownIcon(
                    width: 230,
                    items: exploreCtrl.categories,
                    hintText: 'SHOP BY CATEGORY',
                    itemLabel: (category) => category.name!,
                  ),
                  Flexible(child: Divider()),
                ],
              ),

              // Top Wear Column
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomDropDownIcon(
                          items: exploreCtrl.categories,
                          hintText: 'TOP WEAR',
                          itemLabel: (category) => category.name!,
                        ),
                      ),
                      Expanded(flex: 3, child: Divider()),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 80,
                            margin: EdgeInsets.only(right: 8),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(ImageConstants.avatarLogo),
                                ),
                                const SizedBox(height: 5),
                                Text('T-SHIRT'),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
