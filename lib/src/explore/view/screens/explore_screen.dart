import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/common/widgets/custom_dropdown_menu.dart';
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
                TabBar(
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
                          onPressed: () {
                            exploreCtrl.selectedIndex.value = 1;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TabBarSection(),
                      TabBarSection(),
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

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      items: ['H&M', 'ZARA', 'GUESS'],
                      hintText: 'BRANDS',
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.pushNamed(RouteNames.store);
                        },
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageConstants.zaraLogo),
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
              Container(
                height: 200,
                margin: EdgeInsets.only(top: 8, left: 8),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.pushNamed(RouteNames.productDescription);
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
                                    image: AssetImage(
                                        ImageConstants.splashBackground),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 100,
                              child: Text(
                                'GAP Bodycon Dress',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                '\$20',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
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
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.pushNamed(RouteNames.productDescription);
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
                                    image: AssetImage(
                                        ImageConstants.splashBackground),
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

          // Top Wear Column
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomDropDownIcon(
                      items: ['SHIRTS', 'T-SHIRT', 'SWEATSHIRTS'],
                      hintText: 'TOP WEAR',
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
    );
  }
}

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(),
                prefixIcon: Icon(Icons.search),
                fillColor: TextFieldColor.offWhite,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              context.pushNamed(RouteNames.search);
            },
            icon: Icon(Icons.tune))
      ],
    );
  }
}
