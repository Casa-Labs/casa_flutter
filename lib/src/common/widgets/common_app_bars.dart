import 'package:flutter/material.dart';

import '../../../utils/color_constant.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool isBodyText;
  final dynamic returnData;
  final VoidCallback? onTap;
  final Widget? widget;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.isBodyText = false,
    this.onTap,
    this.returnData,
    this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BackgroundColor.white,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                if (onTap != null) {
                  onTap!();
                } else {
                  if (returnData != null) {
                    Navigator.of(context).pop(returnData);
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(Icons.arrow_back_ios),
            )
          : const SizedBox(),
      title: widget ??
          (isBodyText
              ? Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                )
              : Text(title)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
