import 'dart:async';
import 'package:flutter/material.dart';
import 'package:casaflutter/src/explore/model/brands_model.dart' as brand;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/string_constant.dart';

class AutoScrollBrandList extends StatefulWidget {
  final List<brand.Data> brands;
  final bool isRight;
  final double? scrollSpeed;

  const AutoScrollBrandList({
    super.key,
    required this.brands,
    required this.isRight,
     this.scrollSpeed,
  });

  @override
  _AutoScrollBrandListState createState() => _AutoScrollBrandListState();
}

class _AutoScrollBrandListState extends State<AutoScrollBrandList> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  double _scrollPosition = 0;
  double _scrollSpeed =  3.0;
  final Duration _interval = Duration(milliseconds: 30);

  @override
  void initState() {
    super.initState();
    _scrollSpeed = widget.scrollSpeed ?? 3.0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollPosition = widget.isRight
          ? 0
          : _scrollController.position.maxScrollExtent;
      _scrollController.jumpTo(_scrollPosition);
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(_interval, (_) {
      if (!_scrollController.hasClients) return;
      _scrollPosition += widget.isRight ? _scrollSpeed : -_scrollSpeed;

      final max = _scrollController.position.maxScrollExtent;
      if (_scrollPosition >= max) {
        _scrollPosition -= max;
        _scrollController.jumpTo(_scrollPosition);
      } else if (_scrollPosition <= 0) {
        _scrollPosition += max;
        _scrollController.jumpTo(_scrollPosition);
      } else {
        _scrollController.jumpTo(_scrollPosition);
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.brands.length * 2;

    return SizedBox(
      height: 125,
      width: double.infinity,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 5),
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final brandItem = widget.brands[index % widget.brands.length];
          return InkWell(
            onTap: () {
              context.pushNamed(
                RouteNames.store,
                pathParameters: {'id': brandItem.id ?? ''},
              );
            },
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        brandItem.logo ?? ImageConstants.dummyNetworkPortrait,
                      ),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ]
                  ),
                ),
                SizedBox(height: 8),
                Text(brandItem.name ?? "",style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          );
        },
      ),
    );
  }
}
