import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_constant.dart';

class ResponseDialog extends StatefulWidget {
  final String text;
  final Function onPressed;
  final bool isErrorDialog;

  const ResponseDialog(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isErrorDialog});

  @override
  State<ResponseDialog> createState() => _ResponseDialogState();

  static showErrorDialog(
      {String errorText = "Something Went Wrong",
      required Function onPressed}) {
    Get.dialog(
        ResponseDialog(
          text: errorText,
          onPressed: onPressed,
          isErrorDialog: true,
        ),
        barrierDismissible: false);
  }
}

class _ResponseDialogState extends State<ResponseDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 16.0), // Adjust as needed
      backgroundColor: Theme.of(context).colorScheme.surface,
      contentPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.all(0),
      elevation: 0,
      shadowColor: BackgroundColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      actions: [
        Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 45),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensure the column takes minimum space
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      widget.onPressed();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.close,
                        color: IconColor.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Icon(
                  widget.isErrorDialog ? Icons.error : Icons.check_circle,
                  color: IconColor.blue,
                  size: 60,
                ),
                SizedBox(height: 1),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.text,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: TextColor.black, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
