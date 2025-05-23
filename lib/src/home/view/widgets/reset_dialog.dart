import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class ResetDialog extends StatelessWidget {
  const ResetDialog(
      {super.key, required this.onYesPressed, required this.onCancelPressed});
  final VoidCallback onYesPressed;
  final VoidCallback onCancelPressed;
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
          spacing: 20,
          children: [
            Text(
              "Reset the filters?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              spacing: 40,
              children: [
                _buildBottomButton("Cancel", onCancelPressed),
                _buildBottomButton("Yes", onYesPressed),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
