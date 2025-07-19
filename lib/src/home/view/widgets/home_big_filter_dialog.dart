import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../controller/home_controller.dart';

class HomeBigFilterDialog extends StatefulWidget {
  const HomeBigFilterDialog({
    super.key,
    required this.onYesPressed,
    required this.onCancelPressed,
  });

  final VoidCallback onYesPressed;
  final VoidCallback onCancelPressed;

  @override
  State<HomeBigFilterDialog> createState() => _HomeBigFilterDialogState();
}

class _HomeBigFilterDialogState extends State<HomeBigFilterDialog> {
  String? selectedGender; // 'MA' or 'FE'

  final homeCtrl = Get.find<HomeController>();

  void selectGender(String genderCode) {
    // Update the global gender state
    homeCtrl.selectedGender.value = genderCode;

    // Fetch products with selected gender
    homeCtrl.fetchProducts({"gender": genderCode}, reset: true);
    homeCtrl.getCategory(homeCtrl.selectedGender.value);

    // Close the dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: BackgroundColor.white.withValues(alpha: 0.7),
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Gender",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => _buildGenderButton('Men', 'MA')),
                Obx(() => _buildGenderButton('Women', 'FE')),
              ],
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade400),
            const SizedBox(height: 10),
            Text(
              "Reset All Filters?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomButton("Cancel", widget.onCancelPressed),
                _buildBottomButton("Yes", widget.onYesPressed),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(String text, String genderCode) {
    final bool isSelected = homeCtrl.selectedGender.value == genderCode;

    return ElevatedButton(
      onPressed: () => selectGender(genderCode),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: Colors.black),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(text),
    );
  }

  Widget _buildBottomButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: text == "Cancel" ? Colors.white : Colors.black,
        foregroundColor: text == "Cancel" ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text),
    );
  }
}
