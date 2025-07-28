import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class FilterSelectionDialog extends StatefulWidget {
  final bool showTabs;
  final bool? isCircleShow;
  final List<String> categories;
  final List<String>? brandLogo;
  final List<String>? initiallySelected;
  final void Function(List<String>) onClear;
  final void Function(List<String>) onDone;

  const FilterSelectionDialog({
    super.key,
    required this.showTabs,
    required this.categories,
    required this.onClear,
    required this.onDone,
    this.brandLogo,
    this.isCircleShow,
    this.initiallySelected,
  });

  @override
  State<FilterSelectionDialog> createState() => _FilterSelectionDialogState();
}

class _FilterSelectionDialogState extends State<FilterSelectionDialog> {
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.initiallySelected ?? []);
  }

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
          children: [
            if (widget.showTabs)
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
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  final category = widget.categories[index];
                  var brand = "";
                  if ((widget.brandLogo ?? []).isNotEmpty) {
                    brand = widget.brandLogo![index];
                  }
                  final isSelected = selected.contains(category);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selected.remove(category);
                        } else {
                          selected.add(category);
                        }
                      });
                    },
                    child: _buildCategoryTile(category, isSelected, brand),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBottomButton("Clear", () {
                  setState(() {
                    selected.clear();
                  });
                  widget.onClear([]);
                  Navigator.of(context).pop();
                }),
                _buildBottomButton("Done", () {
                  widget.onDone(selected);
                  Navigator.of(context).pop();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(String category, bool isSelected, String? brand) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            widget.isCircleShow ?? true ?
            (brand ?? "").isNotEmpty
                ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)
              ),
                  child: CircleAvatar(
                      radius: 20,
                              backgroundColor: Colors.white,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(brand ?? "",fit: BoxFit.fill,)),
                    ),
                )
                : CircleAvatar(
                    backgroundColor:
                        isSelected ? Colors.white : Colors.grey.shade300,
                    radius: 18,
                  ) : SizedBox(),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: isSelected ? Colors.white : Colors.grey),
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
}
