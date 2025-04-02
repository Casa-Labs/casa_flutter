import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final bool showCircularProgressIndicator;
  final BoxFit fit;
  final String? url; // Made it nullable

  const NetworkImageWidget({
    Key? key,
    this.height = 100,
    this.width = 100,
    this.borderRadius = 120,
    this.showCircularProgressIndicator = false,
    this.fit = BoxFit.fill,
    this.url, // Nullable URL
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,
        width: width,
        child: CachedNetworkImage(
          fit: fit,
          imageUrl: url != null && url!.isNotEmpty ? url! : "AppConstants.dummyImageUrl", // Use dummy image if URL is null/empty
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, _, object) {
            return Container(
              decoration:  BoxDecoration(color: Colors.grey.shade200),
              child: const Center(
                child: Icon(Icons.error, size: 24),
              ),
            );
          },
        ),
      ),
    );
  }
}
