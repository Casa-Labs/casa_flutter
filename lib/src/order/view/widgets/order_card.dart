import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';

class OrderCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String brandName;
  final String quantity;

  const OrderCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.brandName,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            child: SizedBox(
                height: 120,
                width: 100,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  cacheWidth: 200, // Limit image size
                  cacheHeight: 240, // Limit image size
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                )),
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
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      '\$$price',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                Text(
                  brandName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: TextColor.black54,
                      ),
                ),
                const SizedBox(height: 3),
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: BackgroundColor.white,
                      border: Border.all(color: BorderColor.black)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Size:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              // fontFamily: Font.gilroy,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'M',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        TextColor.black.withValues(alpha: 0.7),
                                    // fontFamily: Font.gilroy,
                                    fontWeight: FontWeight.w600,
                                  ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Qty:',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                        )),
                    Container(
                      height: 24,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: BorderColor.black),
                        color: BackgroundColor.white,
                      ),
                      child: Center(
                          child: Text(
                        quantity,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
