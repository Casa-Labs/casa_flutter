import 'package:flutter/material.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';
import '../../onboarding/view/widget/common_filter_dialog.dart';

class FilterRow extends StatelessWidget {
  final List<dynamic> item;
  const FilterRow({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        child:  SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: CColor.filterColor,
                child:  Icon(Icons.tune_rounded,size: 20,color: CColor.black),
              ),
              ListView.builder(
                  itemCount: item.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: CColor.transparent,
                      highlightColor: CColor.transparent,
                      onTap: () => _showTextInputDialog(context),
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
                ),
            ],
          ),
        ),
      );
  }

  void _showTextInputDialog(BuildContext context) async {
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
              backgroundColor: Colors.white54,
              content: CommonFilterDialog(),
            );
          },
        );
      },
    );
  }
}


