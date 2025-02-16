import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showToast({
  required String message,
  Duration snackBarDisplayDuration = const Duration(milliseconds: 4000),
}) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      duration: snackBarDisplayDuration,
      backgroundColor: Colors.black,
      content: Text(
        message,
      ),
    ),
    snackBarAnimationStyle: AnimationStyle(
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    ),
  );
}
