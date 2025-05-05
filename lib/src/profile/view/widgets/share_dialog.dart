import 'package:casaflutter/src/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';

class ShareAppDialog extends StatelessWidget {
  final String appName;
  final String iosAppLink;
  final String androidAppLink;
  final String shareMessage;

  ShareAppDialog({
    super.key,
    required this.appName,
    required this.iosAppLink,
    required this.androidAppLink,
    this.shareMessage = "Check out this amazing app!",
  });

  final homeCtrl = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (logic) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                'Share',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              // App Store buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _storeButton(() => logic.selectApple(), Icons.apple_rounded,
                      'Apple', logic.isSelectApple),
                  SizedBox(height: 10),
                  _storeButton(() => logic.selectPlay(),
                      Icons.play_arrow_rounded, 'Android', logic.isSelectPlay),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _button("Close", logic, context,
                      () => Navigator.of(context).pop()),
                  SizedBox(width: 10),
                  _button(
                      "Share",
                      logic,
                      context,
                      () => logic.shareApp(
                          logic.isSelectPlay ? androidAppLink : iosAppLink,
                          appName)),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  _storeButton(VoidCallback onTap, IconData icon, String label, bool isSelect) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            Text(label),
            isSelect ? Icon(TablerIcons.check) : SizedBox(width: 24)
          ],
        ),
      ),
    );
  }

  _button(String label, ProfileController logic, BuildContext context,
      Function() onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            // minimumSize: size,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: BorderColor.black, width: 1)),
            foregroundColor: Colors.white,
            alignment: Alignment.center),
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
