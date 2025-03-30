import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/common/widgets/textfields.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          SizedBox(width: 5),
          Text(
            'CASA',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(width: 10),
          Expanded(
            child: SizedBox(height: 30, child: CustomSearchBar()),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed(RouteNames.notifications);
          },
          icon: Icon(Icons.notifications_outlined),
          iconSize: 25,
          color: IconColor.black,
          style: IconButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.tune_rounded),
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
