import 'package:casaflutter/src/cart/model/cart_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/string_constant.dart';
import '../../controller/order_review_controller.dart';

class OrderViewItemWidget extends StatelessWidget {
  final ProductForCart item;
  final Function() onorderItemDelete;
  final orderReviewController = Get.find<OrderReviewController>();

  OrderViewItemWidget(
      {super.key, required this.item, required this.onorderItemDelete});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        decoration: BoxDecoration(
          color: TextColor.white,
          border: Border.all(color: TextColor.black, width: 0.7),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 2,
                  color: ButtonColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Image.network(item.mainImage!, fit: BoxFit.fill)
                        //  Image.asset(
                        //   'assets/images/placeholder.png',
                        //   fit: BoxFit.fill,
                        // ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.name!,
                                style: textTheme.bodyLarge?.copyWith(
                                  // fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "₹${item.price!}",
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Zara',
                          style: textTheme.bodyMedium?.copyWith(
                            // fontSize: 16,
                            color: TextColor.black54,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(ImageConstants.ruler),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Size Guide',
                              style: textTheme.bodySmall?.copyWith(
                                color: TextColor.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Size:',
                              style: textTheme.bodyMedium?.copyWith(
                                // fontSize: 14,
                                color: TextColor.black54,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'M',
                              style: textTheme.bodyMedium?.copyWith(
                                // fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Quantity:',
                              style: textTheme.bodyMedium?.copyWith(
                                // fontSize: 14,
                                color: TextColor.black54,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(106, 217, 217, 217)),
                              child: Text(
                                item.quantity.toString(),
                                style: textTheme.bodyMedium?.copyWith(
                                  // fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        IconButton(
                            highlightColor: IconColor.transparent,
                            icon: Icon(Icons.delete),
                            // icon: SvgPicture.asset(
                            //   'assets/icon/delete.svg',
                            //   height: 23,
                            //   width: 23,
                            // ),
                            onPressed: onorderItemDelete),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
