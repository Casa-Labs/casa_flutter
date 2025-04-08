import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';

class StarRatingButton extends StatefulWidget {
  const StarRatingButton({
    super.key,
    required this.getreview,
  });
  final Function(int review) getreview;

  @override
  State<StarRatingButton> createState() => StarRatingButtonState();
}

class StarRatingButtonState extends State<StarRatingButton> {
  int _rating = 0;

  void _setRating(int index) {
    setState(() {
      _rating = index + 1;
    });
    widget.getreview(_rating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_outline_outlined,
            color: index < _rating ? ButtonColor.yellow : ButtonColor.grey,
            size: 40,
          ),
          onPressed: () => _setRating(index),
        );
      }),
    );
  }
}
