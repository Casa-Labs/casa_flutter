import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/common/widgets/dropdown.dart';
import 'package:casa_flutter/src/common/widgets/textfields.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/color.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {super.key,
      this.isNotification = true,
      this.isFilter = true,
      this.isLeading = true,
      this.isLeadingBack = false,
      this.isSupport = false,
      this.title = ''});

  final bool isNotification;
  final bool isFilter;
  final bool isLeading;
  final bool isLeadingBack;
  final bool isSupport;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BackgroundColor.white,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 2,
      centerTitle: true,
      leadingWidth: isLeading
          ? isLeadingBack
              ? 130
              : 100
          : isLeadingBack
              ? 50
              : 15,
      leading: isLeading
          ? Row(
              children: [
                if (isLeadingBack)
                  InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 2, 12),
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                Expanded(
                  child: CustomDropDown(
                    items: const [
                      'Brands',
                      'Thrift',
                    ],
                    hint: Padding(
                        padding: EdgeInsets.only(left: isLeadingBack ? 0 : 8),
                        child: Row(
                          children: [
                            Text(
                              'CASA',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontSize: 22,
                                    // fontFamily:
                                    //     Font.montaga, // Custom font, if needed
                                  ),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded,
                                color: CColor.black)
                          ],
                        )),
                    width: 150,
                    mode: DropdownMode.single,
                    fontSize: 15,
                    menufontSize: 20,
                    fullSize: false,
                    onSelected: (selectedItems) {},
                    label: '',
                  ),
                ),
              ],
            )
          : isLeadingBack
              ? InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                )
              : SizedBox(),
      title: title != ""
          ? Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            )
          : Container(
              height: 40,
              decoration: BoxDecoration(
                color: TextFieldColor.grey200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: CustomSearchBar(),
            ),
      elevation: 0,
      actions: [
        const SizedBox(width: 5),
        if (isNotification)
          InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              context.pushNamed(RouteNames.notifications);
            },
            child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.notifications_none_rounded,
                    color: CColor.black)),
          ),
        const SizedBox(width: 5),
        if (isFilter)
          InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => FilterPage(),
              //     ));
              context.pushNamed(RouteNames.search);
            },
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.tune_rounded, color: CColor.black)),
          ),
        if (isSupport)
          InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => FilterPage(),
              //     ));
            },
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.headphones, color: CColor.black)),
          ),
        const SizedBox(width: 15),
      ],
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(10),
      //   child: Container(
      //     height: 2.5,
      //     width: double.infinity,
      //     decoration: BoxDecoration(
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black.withOpacity(0.4),
      //           blurRadius: 4,
      //           offset: const Offset(0, 6),
      //         ),
      //       ],
      //     ),
      //     child: const Divider(),
      //   ),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
