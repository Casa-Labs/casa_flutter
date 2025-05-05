import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/src/wishlist/view/widgets/icons_widget.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BannerImage extends StatelessWidget {
  final String imageUrl;
  const BannerImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: 150,
          ),
        ),
        IconsWidget(
          onTap: () {
            context.pop();
          },
          icon: Icons.arrow_back_ios_new,
          backColor: IconColor.white,
          iconColor: IconColor.black,
        ).paddingAll(10),
      ],
    );
  }
}
