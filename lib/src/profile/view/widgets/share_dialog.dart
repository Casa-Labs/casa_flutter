import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // You can also use `share` package

class ShareAppDialog extends StatefulWidget {
  final String appName;
  final String iosAppLink;
  final String androidAppLink;
  final String shareMessage;

  const ShareAppDialog({
    super.key,
    required this.appName,
    required this.iosAppLink,
    required this.androidAppLink,
    this.shareMessage = "Check out this amazing app!",
  });

  @override
  State<ShareAppDialog> createState() => _ShareAppDialogState();
}

class _ShareAppDialogState extends State<ShareAppDialog> {
  bool isAppleSelected = false;
  bool isAndroidSelected = true;

  void shareApp() {
    final link = isAndroidSelected ? widget.androidAppLink : widget.iosAppLink;
    final message = '${widget.shareMessage} \n\n$link';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                _storeButton(() {
                  setState(() {
                    isAppleSelected = true;
                    isAndroidSelected = false;
                  });
                }, Icons.apple_rounded, 'Apple', isAppleSelected),
                const SizedBox(height: 10),
                _storeButton(() {
                  setState(() {
                    isAppleSelected = false;
                    isAndroidSelected = true;
                  });
                }, Icons.play_arrow_rounded, 'Android', isAndroidSelected),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _button("Close", () => Navigator.of(context).pop()),
                const SizedBox(width: 10),
                _button("Share", shareApp),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _storeButton(
      VoidCallback onTap, IconData icon, String label, bool isSelected) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            Text(label),
            isSelected
                ? const Icon(Icons.check, size: 20)
                : const SizedBox(width: 24)
          ],
        ),
      ),
    );
  }

  Widget _button(String label, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.black, width: 1),
          ),
        ),
        child: Text(label, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
