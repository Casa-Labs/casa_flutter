import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageURL;
  final double price;
  final String offerTag;
  final void Function()? onTap;
  final int index;
  final Widget wishlistIcon;

  const ProductCard({
    super.key,
    required this.name,
    required this.imageURL,
    required this.price,
    required this.offerTag,
    required this.onTap,
    required this.index,
    required this.wishlistIcon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), // ✅ Makes the tap effect rounded
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // ✅ Ensures a proper background
          borderRadius: BorderRadius.circular(12), // ✅ Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1), // ✅ Soft shadow
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              12), // ✅ Ensures image also gets rounded corners
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imageURL,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    wishlistIcon,
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '₹ ${price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
