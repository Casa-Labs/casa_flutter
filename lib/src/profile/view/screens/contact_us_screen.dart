import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/profile_controller.dart';

class ContactUsScreen extends StatelessWidget {
   ContactUsScreen({super.key});
var controller=Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please send an email to casa.helpme@gmail.com'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchEmail,
              child: const Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch the email client
  Future<void> _launchEmail() async {
    final name = controller.loggedInUser.value;
    final email = controller.loggedInEmail.value;
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'casa.helpme@gmail.com',
      //query: Uri.encodeFull('subject=Support Request&body=Hi, I need help with...'),
      query: Uri.encodeFull(
        'subject=Contact Us - CASA App&body=Hi CASA Team,\n\n I would like to get in touch regarding the CASA shopping app.'
            '\n\n Name: $name \n\n Email: $email \n\n'
            'Thank you!',
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }
}
