import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/common/widgets/textfields.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../explore/view/widgets/reusable_dropdown.dart';

class HomeSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeSearchAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      leading: SizedBox(),
      title: Row(
        children: [
          SizedBox(width: 5),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: ReusableDropdown(
              items: const [
                // Todo : Add back the dropdown later
                'Brands',
                'Thrift',
              ],
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      'CASA',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              width: MediaQuery.sizeOf(context).width * 0.4,
              mode: DropdownMode.single,
              fullSize: false,
              onSelected: (selectedItems) {},
              label: '',
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: SizedBox(
                height: 30,
                child: CustomSearchBar(
                  onTap: () {
                    context.pushNamed(RouteNames.searchView);
                  },
                )),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed(RouteNames.notifications);
          },
          icon: Image.asset(
            IconConstants.notifications,
            width: 28.0,
            height: 28.0,
          ),
          iconSize: 25,
          color: IconColor.black,
          style: IconButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ],
    );
  }
}
