import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final dynamic returnData; // ✅ Optional return data
  final VoidCallback? onTap;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onTap,
    this.returnData, // ✅ Default is null (optional)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        onPressed: () {
          if (onTap != null) {
            onTap!(); // ✅ Custom onTap if provided
          } else {
            if (returnData != null) {
              Navigator.of(context).pop(returnData); // ✅ Pass data only if not null
            } else {
              Navigator.of(context).pop(); // ✅ Just pop if no data
            }
          }
        },
        icon: const Icon(Icons.arrow_back_ios),
      ):const SizedBox(),
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
