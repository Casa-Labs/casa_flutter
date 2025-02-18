import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemBuilder<T> = Widget Function(T item);

class FutureObxBuilder<T> extends StatelessWidget {
  final Future<void> Function() fetchData;
  final Rx<T?> item;
  final ItemBuilder<T> itemBuilder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final bool enablePullToRefresh;
  final RxBool isLoading = false.obs; // State for refresh indicator

  FutureObxBuilder({
    super.key,
    required this.fetchData,
    required this.item,
    required this.itemBuilder,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.enablePullToRefresh = false,
  });

  Future<void> _refresh() async {
    isLoading.value = true;
    await fetchData();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ??
              const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              errorWidget ?? const Text("Something went wrong"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _refresh,
                child: const Text("Retry"),
              ),
            ],
          );
        }

        return Obx(() {
          if (item.value == null) {
            return emptyWidget ??
                const Center(child: Text("No data available"));
          }

          return enablePullToRefresh
              ? RefreshIndicator(
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: itemBuilder(item.value as T),
                  ),
                )
              : itemBuilder(item.value as T);
        });
      },
    );
  }
}
