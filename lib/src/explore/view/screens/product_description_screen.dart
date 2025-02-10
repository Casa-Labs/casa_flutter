import 'package:casa_flutter/utils/color_constant.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../routes/app_routes.dart';
import '../../../common/widgets/add_to_cart_button.dart';
import '../../../common/widgets/select_size_button.dart';
import '../widgets/care_composition_tile.dart';
import '../widgets/quantity_selector_button.dart';

class ProductDescriptionScreen extends StatelessWidget {
  const ProductDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(ImageConstants.avatarLogo),
                  radius: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ZARA',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text('Visit store',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConstants.placeholderProduct,
                      scale: 1.82,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.pushNamed(RouteNames.cart);
                            },
                            icon: const Icon(Icons.add_shopping_cart_outlined),
                            color: IconColor.white,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                          BuyNowButton(
                            onPressed: () {
                              context.pushNamed(RouteNames.orderReview);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Share.share(
                        'Check out this amazing product at CASA app now !');
                  },
                  icon: Icon(Icons.send_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.mode_comment_outlined),
                ),
                Spacer(),
                InkWell(
                  child: Icon(Icons.bookmark_border),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Viscose Long Coat',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Long sleeve coat with a lapel collar. Front button fastening.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Rs. 1000',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            SelectSizeButton(),
            const SizedBox(height: 20),
            Center(child: QuantitySelectorButton()),
            const SizedBox(height: 20),
            AddToCartButton(
              onPressed: () {
                // Get.to(() => const PaymentOptionsScreen());
                Get.snackbar('Item added to cart successfully',
                    'Not really until API integrates');
              },
            ),
            const SizedBox(height: 40),
            const CareCompositionTile(),
          ],
        ),
      ),
    );
  }
}

class BuyNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BuyNowButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      ),
      onPressed: onPressed,
      child: Text(
        'Buy now',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 13,
          shadows: [
            Shadow(
              offset: const Offset(1.0, 1.0),
              blurRadius: 6.0,
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
