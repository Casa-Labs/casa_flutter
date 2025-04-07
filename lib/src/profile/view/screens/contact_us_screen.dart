import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

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
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'casa.helpme@gmail.com',
      query: Uri.encodeFull('subject=Support Request&body=Hi, I need help with...'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }
}
