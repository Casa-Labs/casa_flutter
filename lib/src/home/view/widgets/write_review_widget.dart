import 'package:casaflutterapp/src/home/model/home_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart' show ButtonColor;
import '../../../common/widgets/buttons/star_rating_button.dart'
    show StarRatingButton;
import '../../../common/widgets/custom_text_form_field_widget.dart';

class WriteReviewWidget extends StatelessWidget {
  const WriteReviewWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  onTap: () => context.pop(),
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
                          getreview: (reviewValue) {},
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Write a review",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomTextFormField(
                  hintText: 'Address',
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
