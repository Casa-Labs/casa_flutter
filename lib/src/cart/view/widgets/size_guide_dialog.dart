import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class SizeGuideDialog extends StatelessWidget {

  const SizeGuideDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: BackgroundColor.white.withValues(alpha: 70),
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Image.asset('assets/images/size_guide.jpeg')
      )
    );
  }
}
