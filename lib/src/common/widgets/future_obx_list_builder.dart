import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemBuilder<T> = Widget Function(T item);

class FutureObxListBuilder<T> extends StatelessWidget {
  final Future<void> Function() fetchData;
  final RxList<T> itemList;
  final ItemBuilder<T> itemBuilder;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;

  const FutureObxListBuilder({
    super.key,
    required this.fetchData,
    required this.itemList,
    required this.itemBuilder,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ??
              const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return errorWidget ??
              const Center(child: Text("Something went wrong"));
        }

        return Obx(() {
          if (itemList.isEmpty) {
            return emptyWidget ??
                const Center(child: Text("No data available"));
          }

          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return itemBuilder(itemList[index]);
            },
          );
        });
      },
    );
  }
}
