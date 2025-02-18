import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';
import '../../onboarding/view/widget/common_filter_dialog.dart';

class FilterRow extends StatelessWidget {
  final List? brandList;
  final List? productList;
  final List? colorList;
  FilterRow({super.key, this.brandList, this.productList, this.colorList});

  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: CColor.filterColor,
              child: Icon(Icons.tune_rounded, size: 20, color: CColor.black),
            ),
            _filterItem('Brand', brandList!, context),
            _filterItem('Product', productList!, context),
            _filterItem('Color', colorList!, context),
            _filterItem('Price', [], context),
            _filterItem('Size', [], context),
            /*  ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: CColor.transparent,
                      highlightColor: CColor.transparent,
                      onTap: () {
                        var children = [];
                        switch (item[index]) {
                          case 'Brand':
                            children = homeCtrl.brandFilter;
                            break;
                          case 'Product':
                            children = homeCtrl.productFilter;
                            break;
                          case 'Color':
                            children = homeCtrl.colorFilter;
                            break;
                          default:
                            children = [];
                            break;
                        }
                        _showTextInputDialog(context,children);
                          },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: CColor.filterColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item[index],
                              style: TextStyle(
                                fontSize: 13,
                                color: CColor.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: Font.gilroy,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(Icons.arrow_drop_down,color: CColor.black)
                          ],
                        ),
                      ),
                    );
                  },
                ),*/
          ],
        ),
      ),
    );
  }

  void _showTextInputDialog(BuildContext context, List children) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              contentPadding: EdgeInsets.all(0),
              insetPadding: EdgeInsets.all(20),
              backgroundColor: DialogColor.white54,
              content: CommonFilterDialog(children: children),
            );
          },
        );
      },
    );
  }

  _filterItem(String filterName, List children, BuildContext context) {
    return InkWell(
      splashColor: CColor.transparent,
      highlightColor: CColor.transparent,
      onTap: () {
        _showTextInputDialog(context, children);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: CColor.filterColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              filterName,
              style: TextStyle(
                fontSize: 13,
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
