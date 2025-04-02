import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class FilterSelectionDialog extends StatelessWidget {
  final bool showTabs;
  final List<String> categories;
  final VoidCallback onClear;
  final VoidCallback onDone;

  const FilterSelectionDialog({
    super.key,
    required this.showTabs,
    required this.categories,
    required this.onClear,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: BackgroundColor.white.withValues(alpha: 70),
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Todo : Uncomment to add Search Bar
            // // Search Bar
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(24),
            //     border: Border.all(color: Colors.grey.shade400),
            //   ),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.search, color: Colors.black54),
            //       hintText: "Search for something",
            //       border: InputBorder.none,
            //       contentPadding: EdgeInsets.symmetric(vertical: 12),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),

            // Tabs (Men/Women)
            if (showTabs)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton("MEN", true),
                  const SizedBox(width: 10),
                  _buildTabButton("WOMEN", false),
                ],
              ),
            const SizedBox(height: 10),

            // Category List
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryTile(categories[index]);
                },
              ),
            ),

            const SizedBox(height: 10),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBottomButton("Clear", onClear),
                _buildBottomButton("Done", onDone),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                category,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: text == "Clear" ? Colors.white : Colors.black,
        foregroundColor: text == "Clear" ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text),
    );
  }
}
