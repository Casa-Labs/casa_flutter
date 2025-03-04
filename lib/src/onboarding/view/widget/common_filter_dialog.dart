import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../common/widgets/price_slider.dart';
import '../../../common/widgets/textfields.dart';
import '../../../home/controller/home_controller.dart';
import '../../../home/model/home_models.dart';

class CommonFilterDialog extends StatefulWidget {
  final List<ProductModelFilter>? children;
  final String? filterName;

  const CommonFilterDialog({super.key, this.children, this.filterName});

  @override
  State<CommonFilterDialog> createState() => _CommonFilterDialogState();
}

class _CommonFilterDialogState extends State<CommonFilterDialog> {
  int index = 0;
  final homeCtrl = Get.find<HomeController>();
  Logger logg = Logger();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.children!.isNotEmpty) ...[
              SizedBox(height: 40, child: CustomSearchBar()),
              if (widget.filterName == "Brand" ||
                  widget.filterName == "Product") ...[
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
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
                        child: InkWell(
                          overlayColor:
                              WidgetStateProperty.all(TabBarColor.transparent),
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            setState(() {
                              index = 0;
                            });
                          },
                          child: Container(
                            height: 36,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: TabBarColor.black),
                                borderRadius: BorderRadius.circular(30),
                                color:
                                    index == 0 ? TabBarColor.black : TabBarColor.white),
                            child: Center(
                                child: Text(
                              "MEN",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: index == 0 ? TextColor.white : TextColor.black,
                              ),
                            )),
                          ),
                        ),
                      ),
                      Tab(
                        child: InkWell(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            setState(() {
                              index = 1;
                            });
                          },
                          child: Container(
                            height: 36,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: TabBarColor.black),
                                borderRadius: BorderRadius.circular(30),
                                color:
                                    index == 1 ? TabBarColor.black : TabBarColor.white),
                            child: Center(
                                child: Text(
                              "WOMEN",
                              style: textTheme.bodyMedium?.copyWith(
                                // fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: index == 1 ? TextColor.white : TextColor.black,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _tabBarList(),
                      _tabBarList(),
                    ],
                  ),
                ),
              ] else ...[
                SizedBox(height: 20),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: _tabBarList())
              ],
              SizedBox(height: 10),
            ] else ...[
/*              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Min'),
                        Text('Max'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 48,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: Colors.black)
                        ),
                        child: CustomTextFormField(
                          hintText: '\$0',
                          fillColor: Colors.white,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 30,
                        color: Colors.black,
                      ),
                      Container(
                        height: 48,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: Colors.black)
                        ),
                        child: CustomTextFormField(
                          hintText: '\$100',
                          fillColor: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),*/
              PriceRangeSlider(
                min: 950.00,
                max: 4950.00,
                onChanged: (double minValue, double maxValue) {
                  // Handle the price range changes here
                  logg.i('Min: $minValue, Max: $maxValue');
                },
              ),
              SizedBox(height: 20),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor: WidgetStateProperty.all(ButtonColor.transparent),
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    var selectedItem = widget.children!
                        .where((element) => element.isSelected)
                        .toList();
                    for (var item in selectedItem) {
                      item.isSelected = false;
                    }
                    setState(() {});
                    // Navigator.of(context).pop();
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ButtonColor.white),
                      child: Text(
                        "Clear",
                        style: textTheme.bodyMedium?.copyWith(
                          // fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(ButtonColor.transparent),
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ButtonColor.black),
                      child: Text(
                        "Done",
                        style: textTheme.bodyMedium?.copyWith(
                          // fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: TextColor.white,
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBarList() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            widget.children![index].isSelected =
                !widget.children![index].isSelected;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              surfaceTintColor: TabBarColor.white,
              color: widget.children![index].isSelected
                  ? TabBarColor.black
                  : TabBarColor.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Row(
                  spacing: 15,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: TabBarColor.black, width: 1.5),
                          borderRadius: BorderRadius.circular(40)),
                      child: CircleAvatar(
                        maxRadius: 18,
                        backgroundColor: const Color(0xFF002957),
                        child: Text(
                          widget.children![index].leading ?? "",
                          style: TextStyle(
                              color: widget.children![index].isSelected
                                  ? TextColor.black
                                  : TextColor.white,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Text(
                      widget.children![index].title ?? "",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 19,
                          color: widget.children![index].isSelected
                              ? TextColor.white
                              : TextColor.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
