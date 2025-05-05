import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String circleImageUrl;
  final String squareImageUrl;
  final String text;
  final String message;
  const NotificationTile(
      {super.key,
      required this.circleImageUrl,
      required this.squareImageUrl,
      required this.text,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: ImageDecorationColor.grey200,
            child: CachedNetworkImage(
              imageUrl: circleImageUrl,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 21,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => SizedBox(
                width: 42,
                // Adjust to match the CircleAvatar radius, double the radius
                height: 42,
                child: const CircularProgressIndicator(
                  color: ProgressIndicatorColor.grey,
                ),
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 21,
                child: const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(squareImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
