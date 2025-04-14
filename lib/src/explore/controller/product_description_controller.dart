import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/explore_products_model.dart' as epm;

class ProductDescriptionController extends GetxController {
  // ========= CONTROLLERS ========= //

  final ScrollController scrollController = ScrollController();

  // ========= VARIABLES ========= //

  RxList<epm.Data?> relatedProducts = <epm.Data>[].obs;

  // Related Products ( Products Call) pagination
  RxInt relatedProductsPage = 1.obs;
  RxInt relatedProductsLimit = 20.obs;
  RxBool relatedProductsIsLoadingMore = false.obs;
  RxBool relatedProductsHasMore = true.obs;

  // ========== STATES ========== //

  @override
  void onReady() async {
    super.onReady();
    await getRelatedProductsCall(isInitialLoad: true);

    // Todo : Handling via a list view controller since infinite scroll is present in product description screen. Fix it later.

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !relatedProductsIsLoadingMore.value &&
          relatedProductsHasMore.value) {
        getRelatedProductsCall();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  // TODO : Clean up the pagination logic, API calls should be handled by service
  Future<void> getRelatedProductsCall({bool isInitialLoad = false}) async {
    logg.i('Get Related Products call in product description');
    if (isInitialLoad) {
      relatedProductsPage.value = 1;
      relatedProductsHasMore.value = true;
      relatedProducts.clear();
    }

    if (!relatedProductsHasMore.value || relatedProductsIsLoadingMore.value) {
      logg.d(
          "Not fetching: hasMore=${relatedProductsHasMore.value}, isLoading=${relatedProductsIsLoadingMore.value}");
      return;
    }

    relatedProductsIsLoadingMore.value = true;

    var response = await GraphQLManager().getRelatedProducts({
      "page": relatedProductsPage.value,
      "pageSize": relatedProductsLimit.value,
    });

    if (!response.hasException && response.data != null) {
      final productsResponse =
          epm.ExploreGetProductsModel.fromJson(response.data!);
      final newProducts = productsResponse.getProducts?.data ?? [];

      if (newProducts.length < relatedProductsLimit.value) {
        relatedProductsHasMore.value = false;
      }

      relatedProducts.addAll(newProducts);
      relatedProductsPage.value++;
    } else {
      logg.e('Get Related Products Exception: ${response.exception}');
    }

    relatedProductsIsLoadingMore.value = false;
  }
}
