import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/font.dart';
import '../../../common/widgets/text_widgets.dart';
import '../../model/home_models.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return  GetBuilder<HomeController>(builder: (logic) {
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
                    child: BodyText(
                      text: product.title ?? ""
                          .toUpperCase(),
                      fontSize: 18,
                      fontFamily: Font.gilroy,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        // Get.bottomSheet(
                        //     AddToCloset(
                        //       newProduct: WhishProductItem(
                        //           imageUrl: logic
                        //               .products[logic.cardIndex != -1
                        //               ? logic.cardIndex
                        //               : 0]
                        //               .images![0]
                        //               .src
                        //               .toString(),
                        //           itemId: logic
                        //               .products[logic.cardIndex != -1
                        //               ? logic.cardIndex
                        //               : 0]
                        //               .id
                        //               .toString()),
                        //     ),
                        //     isScrollControlled: true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Icon(Icons.bookmark_border_rounded),
                      ))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BodyText(
                    text: 'Description:',
                    fontSize: 15,
                  ),
                  BodyText(
                    text:
                    '₹${product.price}',
                    fontSize: 14,
                    fontFamily: Font.gilroy,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              product
                  .description!.isNotEmpty
                  ? BodyText(
                text: product.description
                    .toString() /* 'Cutout zipper sleeveless in multi-colour fashion. This is a really durable pant with been used only 3 months! Buy now and get 30% discount with the code :first up'*/,
                fontSize: 12,
                textAlign: TextAlign.start,
              )
                  : SizedBox(),
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
              const BodyText(
                text: 'Size:',
                fontSize: 14,
              ),
              const SizedBox(height: 8),

              // ListView for size selection
              SizedBox(
                height: 50, // Adjust height based on your design
                child: product.sizes!.isEmpty
                    ? Text(
                  'all sizes available',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: /*isSelected
                                    ? Colors.black
                                    :*/
                    Colors.grey,
                  ),
                )
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.sizes!
                      .length, // Use the sizes list length
                  itemBuilder: (context, index) {
                    // final size = products[currentIndex]
                    //     .sizes[
                    // index]; // Get the size at the index
                    // final isSelected =
                    //     selectedSizeIndex == index;

                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: 42, // Fixed width for uniformity
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            border: /*isSelected
                                ? Border.all(
                                color: Colors.black,
                                width: 1.5)
                                : */
                            Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              'size', // Display the size text
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: /*isSelected
                                    ? Colors.black
                                    :*/
                                Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      if (logic.counter.value > 1) {
                        logic.counter.value -= 1;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        width: 40, // Fixed width for uniformity
                        decoration: BoxDecoration(
                            color: const Color(0xFFF4F4F4),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)
                          // borderRadius:
                          //     BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Icon(
                              Icons.remove,
                              size: 15,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    child: ValueListenableBuilder<int>(
                        valueListenable: logic.counter,
                        builder: (context, value, child) {
                          return Container(
                            padding: const EdgeInsets.all(4),
                            width: 100, // Fixed width for uniformity
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[300],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: BodyText(
                                text: '$value',
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }),
                  ),
                  InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      if (logic.counter.value < 5) {
                        logic.counter.value += 1;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          width: 40, // Fixed width for uniformity
                          decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)
                            // borderRadius:
                            //     BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 15,
                              ))),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  // _addToCart(context, logic);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          width: 100, // Fixed width for uniformity
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBE14B),
                            border: Border.all(
                                color: const Color.fromARGB(255, 221, 198, 95)),
                            // color: Colors.grey[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: BodyText(
                              text: 'ADD TO CART',
                              fontSize: 12,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                // No horizontal spacing
                shrinkWrap: true,
                itemCount: /*product.images!.length > 4
                    ? 4
                    : product.images!.length*/0,
                // Makes GridView fit its content
                physics: const NeverScrollableScrollPhysics(),
                // Disables scrolling
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return
                    GestureDetector(
                      onTap: (){},
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            product.images![index].src
                                .toString(),
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BodyText(
                                text: '',
                                color: Colors.white,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
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
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: Font.gilroy),
                          ),
                          logic.isShowReturn
                              ? const Icon(Icons.keyboard_arrow_up_rounded,
                              size: 15, color: Colors.black54)
                              : const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 15, color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                  logic.isShowReturn
                      ? Text(
                    'This product have no any return policy',
                    style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontFamily: Font.gilroy),
                  )
                      : const SizedBox(),
                ],
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
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: Font.gilroy),
                          ),
                          logic.isShowShipping
                              ? const Icon(Icons.keyboard_arrow_up_rounded,
                              size: 15, color: Colors.black54)
                              : const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 15, color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                  logic.isShowShipping
                      ? Text(
                    'For order values below \$50, product charges a \$8 shipping fee.',
                    style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontFamily: Font.gilroy),
                  )
                      : const SizedBox(),
                ],
              ),
              const Divider(thickness: 1, color: Colors.black26),
              const SizedBox(
                height: 10,
              ),
              const BodyText(
                text: 'Reviews',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: CircleAvatar(
                          maxRadius: 28,
                          backgroundColor: const Color(0xFF002957),
                          child: Text(
                            "ZARA".substring(0, 4).toUpperCase(),
                            style:
                            const TextStyle(color: Colors.white, fontSize: 14),
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
                          const BodyText(
                            text: 'Steve_vora_04',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0; i < 5; i++) const Icon(Icons.star),
                              const SizedBox(
                                width: 10,
                              ),
                              const BodyText(
                                text: '5/5',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      BodyText(
                        text: 'More',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
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
      }
    );
  }
}
