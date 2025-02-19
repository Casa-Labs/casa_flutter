import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/color.dart';
import '../../../home/model/home_models.dart';
import 'counter_widget.dart';

class CartItem extends StatefulWidget {
  final ProductModel item;
  final VoidCallback onDelete;
  final int index;
  final Function() totalChange;

  const CartItem({
    super.key,
    required this.item,
    required this.onDelete,
    required this.index,
    required this.totalChange,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  bool _isRemoved = false;
  int selectedSizeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(2, 0), // Move out to the right
    ).chain(CurveTween(curve: Curves.easeInOutCubic)).animate(_controller);

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
    setState(() {});
  }

  void _showDialog(Widget child, BuildContext ctx) {
    showCupertinoModalPopup<void>(
      context: ctx,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0, right: 6),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                overlayColor: WidgetStateProperty.all(ButtonColor.transparent),
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  Navigator.pop(ctx);
                  widget.item.selectedSizePosition = selectedSizeIndex;
                },
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Done',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: TextColor.black,
                            fontWeight: FontWeight.w700,
                          ),
                    )),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    ).then(
      (value) {
        setState(() {});
      },
    );
  }

  void _deleteItem() async {
    await _controller.forward(); // Start animation
    setState(() {
      _isRemoved = true; // Remove from UI
    });
    widget.onDelete(); // Remove from the controller
  }

  void _increment() {
    if (widget.item.quantity! < 50) {
      setState(() {
        widget.item.quantity = (widget.item.quantity ?? 0) + 1;
      });
      widget.totalChange();
    } else {}
  }

  void _decrement() {
    if (widget.item.quantity! > 1) {
      setState(() {
        widget.item.quantity = (widget.item.quantity ?? 0) - 1;
      });
      widget.totalChange();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    if (_isRemoved) {
      return const SizedBox.shrink(); // Return an empty widget once removed
    }
    final textTheme = Theme.of(context).textTheme;

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
          opacity: _opacityAnimation,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        widget.item.images![0].src.toString(),
                        fit: BoxFit.cover,
                        width: 108.25,
                        height: 166,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                widget.item.title!,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                              Text(
                                "₹${widget.item.price!.replaceAll('Rs.', '').replaceAll(' ', '')}",
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Zara',
                            style: textTheme.bodyMedium?.copyWith(
                              color: TextColor.black54,
                            ),
                          ),
                          if (widget.item.sizes != null &&
                              widget.item.sizes!.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset('assets/icon/ruler.svg'),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Size Guide',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: TextColor.black54,
                                  ),
                                )
                              ],
                            ),
                          if (widget.item.sizes != null &&
                              widget.item.sizes!.isNotEmpty)
                            Container(
                              height: 36,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: CColor.languageBorderColor),
                              child: Row(
                                children: [
                                  Text(
                                    'Size:',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: TextColor.black.withValues(alpha: 0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          selectedSize(widget
                                              .item.selectedSizePosition!),
                                          style: textTheme.bodyMedium?.copyWith(
                                            fontSize: 15,
                                            color:
                                                TextColor.black.withValues(alpha: 0.7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _showDialog(
                                          CupertinoPicker(
                                            magnification: 1.5,
                                            squeeze: 0.6,
                                            useMagnifier: true,
                                            itemExtent: 30,
                                            // This sets the initial item.
                                            scrollController:
                                                FixedExtentScrollController(
                                              initialItem: widget
                                                  .item.selectedSizePosition!,
                                            ),
                                            // This is called when selected item is changed.
                                            onSelectedItemChanged:
                                                (int selectedItem) {
                                              setState(() {
                                                selectedSizeIndex =
                                                    selectedItem;
                                              });
                                            },
                                            children: List<Widget>.generate(
                                                widget.item.sizes!.length,
                                                (int index) {
                                              return Center(
                                                  child: Text(
                                                widget.item.sizes![index],
                                                style: textTheme.titleLarge
                                                    ?.copyWith(fontSize: 25),
                                              ));
                                            }),
                                          ),
                                          context);
                                    },
                                    highlightColor: ButtonColor.transparent,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFD9D9D9)),
                            child: CounterWidget(
                                count: widget.item.quantity!,
                                removeTap: _decrement,
                                addTap: _increment),
                          ),
                          IconButton(
                            highlightColor: ButtonColor.transparent,
                            icon: SvgPicture.asset(
                              'assets/icon/delete.svg',
                              height: 23,
                              width: 23,
                            ),
                            onPressed: _deleteItem,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String selectedSize(int size) {
    var selectedSize = "S";
    switch (size) {
      case 0:
        selectedSize = 'S';
        break;
      case 1:
        selectedSize = 'M';
        break;
      case 2:
        selectedSize = 'L';
        break;
      case 3:
        selectedSize = 'XL';
        break;
      case 4:
        selectedSize = 'XXL';
        break;
      default:
        selectedSize = 'S'; // Optional default case
    }
    return selectedSize;
  }
}
