import 'package:casaflutterapp/src/common/widgets/app_bar.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';

class DevelopmentScreen extends StatelessWidget {
  const DevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        isLeadingBack: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConstants.development),
            Text('Uh Oh! This screen is under development'),
          ],
        ),
      ),
    );
  }
}
