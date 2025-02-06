import 'package:flutter/material.dart';

import '../../../common/widgets/text_widgets.dart';
import '../../../common/widgets/textfields.dart';

class CommonFilterDialog extends StatefulWidget {
  const CommonFilterDialog({super.key});

  @override
  State<CommonFilterDialog> createState() => _CommonFilterDialogState();
}

class _CommonFilterDialogState extends State<CommonFilterDialog> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .63,
        child: Column(
          children: [
            SizedBox(height: 40, child: CustomSearchBar()),
            TabBar(
              indicatorWeight: 1,
              dividerHeight: 0,
              splashFactory: NoSplash.splashFactory,
              indicator: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.transparent)),
              labelPadding: const EdgeInsets.symmetric(horizontal: 2),
              tabs: [
                Tab(
                  child: InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                      height: 36,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                          color: index == 0 ? Colors.black : Colors.white),
                      child: Center(
                        child: BodyText(
                            text: "MEN",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: index == 0 ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      height: 36,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                          color: index == 1 ? Colors.black : Colors.white),
                      child: Center(
                        child: BodyText(
                            text: "WOMEN",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: index == 1 ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _tabbarList(),
                  _tabbarList(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: BodyText(
                      text: "Clear",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: BodyText(
                      fontWeight: FontWeight.w500,
                      text: "Done",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabbarList() {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Row(
              spacing: 15,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(40)),
                  child: CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: const Color(0xFF002957),
                    child: Text(
                      "ZARA".substring(0, 4).toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                BodyText(
                  text: "Zara",
                  fontSize: 24,
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 15,
        );
      },
    );
  }
}
