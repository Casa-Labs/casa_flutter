import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
import '../../../utils/color_constant.dart';
import '../../home/controller/home_controller.dart';

class CasaButton extends StatelessWidget {
  final bool? isLeadingBack;

  const CasaButton({super.key, this.isLeadingBack});

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeController>();
    return GestureDetector(
      onTap: () {
        _showDialog(context, homeCtrl);
      },
      child: Padding(
          padding: EdgeInsets.only(left: isLeadingBack! ? 0 : 8),
          child: Row(
            children: [
              Text(
                'CASA',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      // fontFamily:
                      //     Font.montaga, // Custom font, if needed
                    ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: CColor.black)
            ],
          )),
    );
  }

  _showDialog(BuildContext context, HomeController homeCtrl) {
    var item = ['BRAND', 'THRIFT'];
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
              content: Wrap(
                children: [
                  Column(
                    children: item
                        .map(
                          (String item) => GestureDetector(
                            onTap: () {
                              homeCtrl.fetchProducts(
                                  {"storeType": item.toUpperCase()});
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: TextColor
                                            .black, // Menu item text color
                                      ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
