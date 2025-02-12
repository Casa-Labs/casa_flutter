import 'package:casa_flutter/src/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool isBodyText;
  final dynamic returnData;
  final VoidCallback? onTap;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.isBodyText = false,
    this.onTap,
    this.returnData,
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
      ):const SizedBox(),
      title: isBodyText?
      BodyText(text: title, fontWeight: FontWeight.w700, fontSize: 23):
      Text(title),
      actions: actions,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
