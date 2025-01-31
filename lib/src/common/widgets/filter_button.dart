import 'package:casa_flutter/src/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../../../utils/font.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const FilterButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0x00d9d9d9), borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BodyText(
                  text: label,
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: Font.gilroy,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(width: 2),
                Icon(Icons.arrow_drop_down_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}