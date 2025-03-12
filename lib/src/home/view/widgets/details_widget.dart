import 'package:casa_flutter/src/common/widgets/buttons/add_to_cart_button.dart';
import 'package:casa_flutter/src/common/widgets/buttons/select_size_button.dart';
import 'package:casa_flutter/src/explore/view/widgets/quantity_selector_button.dart';
import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/font.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';
import '../../model/home_models.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<HomeController>(builder: (logic) {
      return GetBuilder<CartController>(builder: (cartLogin) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    (product.name ?? "").toUpperCase(),
                    style: textTheme.bodyLarge?.copyWith(
                      fontFamily: Font.gilroy, // Custom font
                    ),
                  )),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return AddToCloset(
                              imageUrl: product.mainImage.toString(),
                              itemId: product.id.toString(),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Icon(Icons.bookmark_border_rounded),
                      ))
                ],
              ),
              const SizedBox(height: 15),
              Text('Description:', style: textTheme.bodyMedium),
              const SizedBox(height: 8),
              product.description!.isNotEmpty
                  ? Text(
                      product.description.toString(),
                      style: textTheme.bodySmall,
                      textAlign: TextAlign.start,
                    )
                  : Text(AppStrings.productDescription,
                      style: textTheme.bodySmall),
              const SizedBox(height: 16),
              /*products[currentIndex].colors.isNotEmpty
                      ? Column(
                    children: [
                      // Color Section
                      const BodyText(
                        text: 'Color:',
                        fontSize: 14,
                      ),
                      const SizedBox(height: 8),
          
                      SizedBox(
                        height:
                        60, // Adjust height based on your design
                        child: ListView.builder(
                          scrollDirection:
                          Axis.horizontal,
                          itemCount:
                          products[currentIndex]
                              .colors
                              .length,
                          itemBuilder: (context, index) {
                            final color =
                            products[currentIndex]
                                .colors[index];
                            final isSelected =
                                selectedColorIndex ==
                                    index;
          
                            return GestureDetector(
                              onTap: () {
                                selectColor(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets
                                    .symmetric(
                                    horizontal: 8),
                                child: Stack(
                                  alignment:
                                  Alignment.center,
                                  children: [
                                    // Background circle with color
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration:
                                      BoxDecoration(
                                        color:
                                        _getColorFromName(
                                            color),
                                        shape: BoxShape
                                            .circle,
                                        border:
                                        Border.all(
                                          color: isSelected
                                              ? (Colors.grey[
                                          300] ??
                                              Colors
                                                  .grey)
                                              : Colors
                                              .transparent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
          
                                    // Check icon overlay
                                    if (isSelected)
                                      const Icon(
                                        Icons.check,
                                        color:
                                        Colors.white,
                                        size:
                                        20, // Icon size
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                      :*/
              const SizedBox.shrink(),
              Text('Size:', style: textTheme.bodySmall),
              const SizedBox(height: 8),

              // ListView for size selection
              // SizedBox(
              //   height: 50, // Adjust height based on your design
              //   child: product.size!.isEmpty
              //       ? Text(
              //           'all sizes available',
              //           style: textTheme.bodySmall?.copyWith(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w500,
              //             color: TextColor.grey, // Dynamic color
              //           ),
              //         )
              //       : ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount:
              //               product.size!.length, // Use the sizes list length
              //           itemBuilder: (context, index) {
              //             // final size = products[currentIndex]
              //             //     .sizes[
              //             // index]; // Get the size at the index
              //             // final isSelected =
              //             //     selectedSizeIndex == index;

              //             return GestureDetector(
              //               onTap: () {},
              //               child: Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 12),
              //                 child: Container(
              //                   padding: const EdgeInsets.all(8),
              //                   width: 42, // Fixed width for uniformity
              //                   decoration: BoxDecoration(
              //                     color: ButtonColor.grey200,
              //                     shape: BoxShape.circle,
              //                     border: /*isSelected
              //                     ? Border.all(
              //                     color: Colors.black,
              //                     width: 1.5)
              //                     : */
              //                         Border.all(color: ButtonColor.grey),
              //                   ),
              //                   child: Center(
              //                     child: Text(
              //                       product.size![index],
              //                       style: textTheme.bodySmall?.copyWith(
              //                         fontWeight: FontWeight.w400,
              //                         color: TextColor.grey, // Dynamic color
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              // ),
              // SelectSizeButton(
              //   size: product.size ?? [],
              // ),
              const SizedBox(height: 20),
              Center(child: QuantitySelectorButton()),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     InkWell(
              //       overlayColor: WidgetStateProperty.all(Colors.transparent),
              //       splashFactory: NoSplash.splashFactory,
              //       onTap: () {
              //         if (logic.counter.value > 1) {
              //           logic.counter.value -= 1;
              //         }
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           padding: const EdgeInsets.all(4),
              //           width: 40, // Fixed width for uniformity
              //           decoration: BoxDecoration(
              //               color: const Color(0xFFF4F4F4),
              //               shape: BoxShape.circle,
              //               border: Border.all(color: Colors.grey)
              //               // borderRadius:
              //               //     BorderRadius.circular(10),
              //               ),
              //           child: const Center(
              //               child: Icon(
              //             Icons.remove,
              //             size: 15,
              //           )),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 2,
              //       ),
              //       child: ValueListenableBuilder<int>(
              //           valueListenable: logic.counter,
              //           builder: (context, value, child) {
              //             return Container(
              //               padding: const EdgeInsets.all(4),
              //               width: 100, // Fixed width for uniformity
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Colors.grey),
              //                 color: Colors.grey[300],
              //                 shape: BoxShape.rectangle,
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               child: Center(
              //                 child: BodyText(
              //                   text: '$value',
              //                   fontSize: 12,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             );
              //           }),
              //     ),
              //     InkWell(
              //       overlayColor: WidgetStateProperty.all(Colors.transparent),
              //       splashFactory: NoSplash.splashFactory,
              //       onTap: () {
              //         if (logic.counter.value < 5) {
              //           logic.counter.value += 1;
              //         }
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //             padding: const EdgeInsets.all(4),
              //             width: 40, // Fixed width for uniformity
              //             decoration: BoxDecoration(
              //                 color: const Color(0xFFF4F4F4),
              //                 shape: BoxShape.circle,
              //                 border: Border.all(color: Colors.grey)
              //                 // borderRadius:
              //                 //     BorderRadius.circular(10),
              //                 ),
              //             child: const Center(
              //                 child: Icon(
              //               Icons.add,
              //               size: 15,
              //             ))),
              //       ),
              //     )
              //   ],
              // ),
              const SizedBox(
                height: 40,
              ),
              AddToCartButton(onPressed: () {
                cartLogin.addProductsToCart(product, logic.quantity.value);
              }),
              // GestureDetector(
              //   onTap: () {
              //     // _addToCart(context, logic);
              //   },
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 2),
              //           child: Container(
              //             padding: const EdgeInsets.all(4),
              //             width: 100, // Fixed width for uniformity
              //             decoration: BoxDecoration(
              //               color: const Color(0xFFFBE14B),
              //               border: Border.all(
              //                   color: const Color.fromARGB(255, 221, 198, 95)),
              //               // color: Colors.grey[300],
              //               shape: BoxShape.rectangle,
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: const Center(
              //               child: BodyText(
              //                 text: 'ADD TO CART',
              //                 fontSize: 12,
              //                 letterSpacing: 2,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.black,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                // No horizontal spacing
                shrinkWrap: true,
                itemCount: product.productImages!.length > 4
                    ? 4
                    : product.productImages!.length,
                // Makes GridView fit its content
                physics: const NeverScrollableScrollPhysics(),
                // Disables scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print('------>>> hello ${product.productImages![index]}');
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          product.productImages![index],
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(thickness: 1, color: Colors.black26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      logic.changeReturnPolicy();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RETURN POLICY',
                            style: TextStyle(
                                fontSize: 13,
                                color: TextColor.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: Font.gilroy),
                          ),
                          logic.isShowReturn
                              ? const Icon(Icons.keyboard_arrow_up_rounded,
                                  size: 15, color: IconColor.black54)
                              : const Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 15, color: IconColor.black54),
                        ],
                      ),
                    ),
                  ),
                  logic.isShowReturn
                      ? Text(
                          'This product have no any return policy',
                          style: TextStyle(
                              fontSize: 12.5,
                              color: TextColor.black54,
                              fontWeight: FontWeight.w500,
                              fontFamily: Font.gilroy),
                        )
                      : const SizedBox(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      logic.changeShippingPolicy();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SHIPPING POLICY',
                            style: TextStyle(
                                fontSize: 13,
                                color: TextColor.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: Font.gilroy),
                          ),
                          logic.isShowShipping
                              ? const Icon(Icons.keyboard_arrow_up_rounded,
                                  size: 15, color: TextColor.black54)
                              : const Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 15, color: TextColor.black54),
                        ],
                      ),
                    ),
                  ),
                  logic.isShowShipping
                      ? Text(
                          'For order values below \$50, product charges a \$8 shipping fee.',
                          style: TextStyle(
                              fontSize: 12.5,
                              color: TextColor.black54,
                              fontWeight: FontWeight.w500,
                              fontFamily: Font.gilroy),
                        )
                      : const SizedBox(),
                ],
              ),
              const Divider(thickness: 1, color: DividerColor.grey),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Reviews',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: TextColor.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            border: Border.all(color: ButtonColor.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: CircleAvatar(
                          maxRadius: 28,
                          backgroundColor: const Color(0xFF002957),
                          child: Text(
                            "ZARA".substring(0, 4).toUpperCase(),
                            style: const TextStyle(
                                color: TextColor.white, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Steve_vora_04',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: TextColor.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0; i < 5; i++)
                                const Icon(Icons.star),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '5/5',
                                style: textTheme.bodyMedium?.copyWith(
                                  // fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: TextColor.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'More',
                        style: textTheme.bodyMedium?.copyWith(
                          // fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: TextColor.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      });
    });
  }
}
