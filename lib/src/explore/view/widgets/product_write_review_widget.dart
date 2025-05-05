import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/src/explore/model/product_by_id_model.dart'
    as model;
import 'package:casaflutter/src/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart'
    show ButtonColor, DividerColor, TextColor;
import '../../../common/widgets/buttons/star_rating_button.dart';
import '../../../common/widgets/custom_text_form_field_widget.dart';

class ProductWriteReviewWidget extends StatelessWidget {
  ProductWriteReviewWidget({super.key, required this.product});

  final model.GetProductDetails product;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height - 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review Product',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          // fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  InkWell(
                    overlayColor:
                        WidgetStateProperty.all(ButtonColor.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      homeController.reviewController!.clear();
                      homeController.reviewStar.value = 0;
                      context.pop();
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(40)),
                        child: const Icon(Icons.close)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 15,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          child: Image.network(
                            product.mainImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          StarRatingButton(
                            getreview: (reviewValue) {
                              homeController.reviewedStarCount(reviewValue);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 0.5, color: DividerColor.grey),
                  Text(
                    "Write a review",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CustomTextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: homeController.reviewController!,
                    hintText:
                        'How is the product? What do you like? What do you hate?',
                    hintStyle: TextStyle(color: TextColor.grey),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ButtonColor.black,
                foregroundColor: ButtonColor.white,
                fixedSize: Size(
                  MediaQuery.of(context).size.width * .9,
                  36.0,
                ),
              ),
              onPressed: () async {
                String massage = await homeController.registerProductReview(
                    product.id!,
                    homeController.reviewStar.value,
                    homeController.reviewController!.text);
                showToast(message: massage);
                homeController.reviewController!.clear();
                homeController.reviewStar.value = 0;
                context.pop();
              },
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
