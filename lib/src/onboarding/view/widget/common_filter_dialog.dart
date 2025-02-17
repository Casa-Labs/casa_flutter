import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../../../common/widgets/text_widgets.dart';
import '../../../common/widgets/textfields.dart';

class CommonFilterDialog extends StatefulWidget {
  final List? children;
  const CommonFilterDialog({super.key, this.children});

  @override
  State<CommonFilterDialog> createState() => _CommonFilterDialogState();
}

class _CommonFilterDialogState extends State<CommonFilterDialog> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .63,
        child: Column(
          children: [
            if (widget.children!.isNotEmpty) ...[
              SizedBox(height: 40, child: CustomSearchBar()),
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
                            color: index == 0
                                ? TabBarColor.black
                                : TabBarColor.white),
                        child: Center(
                            child: Text(
                          "MEN",
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                index == 0 ? TextColor.white : TextColor.black,
                          ),
                        )),
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
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: TabBarColor.black),
                            borderRadius: BorderRadius.circular(30),
                            color: index == 1
                                ? TabBarColor.black
                                : TabBarColor.white),
                        child: Center(
                            child: Text(
                          "WOMEN",
                          style: textTheme.bodyMedium?.copyWith(
                            // fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                index == 1 ? TextColor.white : TextColor.black,
                          ),
                        )),
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
                    _tabBarList(),
                    _tabBarList(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ] else ...[
              Column(
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
                          color: TextFieldColor.white,
                          borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: Colors.black)
                        ),
                        child: CustomTextFormField(
                          hintText: '\$0',
                          fillColor: TextFieldColor.white,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 30,
                        color: ButtonColor.black,
                      ),
                      Container(
                        height: 48,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ButtonColor.white,
                          borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: Colors.black)
                        ),
                        child: CustomTextFormField(
                          hintText: '\$100',
                          fillColor: TextFieldColor.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
            ],
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
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            surfaceTintColor: TabBarColor.white,
            color: TabBarColor.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                spacing: 15,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TabBarColor.black, width: 1.5),
                        borderRadius: BorderRadius.circular(40)),
                    child: CircleAvatar(
                      maxRadius: 16,
                      backgroundColor: const Color(0xFF002957),
                      child: Text(
                        "ZARA".substring(0, 4).toUpperCase(),
                        style: const TextStyle(color: TextColor.white, fontSize: 12),

                      ),
                    ),
                  ),
                  Text(
                    widget.children![index],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                        ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
