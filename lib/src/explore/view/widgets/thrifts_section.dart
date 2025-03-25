import 'package:casaflutterapp/src/common/widgets/custom_dropdown_menu.dart';
import 'package:casaflutterapp/src/explore/controller/explore_controller.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';

class ThriftsSection extends StatelessWidget {
  const ThriftsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreCtrl = Get.find<ExploreController>();

    return RefreshIndicator(
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
                        items: ['H&M', 'ZARA', 'GUESS'],
                        hintText: 'THRIFTS STORE',
                        itemLabel: (item) => item,
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

            // Shop By Category Row
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDropDownIcon(
                  width: 230,
                  items: ['MEN', 'WOMEN', 'KIDS'],
                  hintText: 'SHOP BY CATEGORY',
                  itemLabel: (item) => item,
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
                        items: ['SHIRTS', 'T-SHIRT', 'SWEATSHIRTS'],
                        hintText: 'TOP WEAR',
                        itemLabel: (item) => item,
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
    );
  }
}
