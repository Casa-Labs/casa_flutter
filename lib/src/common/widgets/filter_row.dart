import 'package:casaflutter/src/home/controller/home_controller.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/model/home_models.dart';
import '../../onboarding/view/widget/common_filter_dialog.dart';

class FilterRow extends StatelessWidget {
  final List<ProductModelFilter>? brandList;
  final List<ProductModelFilter>? productList;
  final List<ProductModelFilter>? colorList;
  final List<ProductModelFilter>? sizedList;
  FilterRow(
      {super.key,
      this.brandList,
      this.productList,
      this.colorList,
      this.sizedList});

  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (logic) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 45,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    logic.showFilter();
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: IconColor.fadeGrey,
                    child: Icon(Icons.tune_rounded,
                        size: 20, color: IconColor.black),
                  ),
                ),
                Visibility(
                  visible: homeCtrl.isShowFilter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _filterItem('Brand', brandList!, context),
                      _filterItem('Product', productList!, context),
                      _filterItem('Color', colorList!, context),
                      _filterItem('Price', [], context),
                      _filterItem('Size', sizedList!, context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showTextInputDialog(BuildContext context,
      List<ProductModelFilter> children, String filterName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.all(20),
              backgroundColor: DialogColor.white54,
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CommonFilterDialog(
                  children: children,
                  filterName: filterName,
                ),
              ),
            );
          },
        );
      },
    );
  }

  _filterItem(String filterName, List<ProductModelFilter> children,
      BuildContext context) {
    return InkWell(
      splashColor: ButtonColor.transparent,
      highlightColor: ButtonColor.transparent,
      onTap: () {
        _showTextInputDialog(context, children, filterName);
      },
      child: Container(
        height: 25,
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: ButtonColor.mildGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              filterName,
              style: TextStyle(
                fontSize: 16,
                color: TextColor.black,
                fontWeight: FontWeight.w500,
                // fontFamily: Font.gilroy,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.arrow_drop_down, color: IconColor.black)
          ],
        ),
      ),
    );
  }
}
