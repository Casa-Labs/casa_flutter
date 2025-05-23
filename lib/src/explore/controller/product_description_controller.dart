import 'dart:math';

import 'package:casaflutter/network/graph_ql_manager.dart';
import 'package:casaflutter/src/explore/model/product_by_id_model.dart'
    as model;
import 'package:casaflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/model/home_models.dart' as home;
import '../model/explore_products_model.dart' as epm;

class ProductDescriptionController extends GetxController {
  // ========= CONTROLLERS ========= //

  final ScrollController scrollController = ScrollController();

  // ========= VARIABLES ========= //

  RxList<epm.Data?> relatedProducts = <epm.Data>[].obs;

  // Related Products ( Products Call) pagination
  RxInt relatedProductsPage = 1.obs;
  RxInt relatedProductsLimit = 10.obs;
  RxBool relatedProductsIsLoadingMore = false.obs;
  RxBool relatedProductsHasMore = true.obs;

  // ========== STATES ========== //

  @override
  void onReady() async {
    super.onReady();
    await getRelatedProductsCall(isInitialLoad: true);

    // Todo : Handling via a list view controller since infinite scroll is present in product description screen. Fix it later.

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //           scrollController.position.maxScrollExtent - 100 &&
    //       !relatedProductsIsLoadingMore.value &&
    //       relatedProductsHasMore.value) {
    //     getRelatedProductsCall();
    //   }
    // });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // ========== UI FUNCTIONS ========== //

  home.Product getProductData(model.GetProductDetails getProductDet) {
    List<home.Sizes> sizes = [];
    List<home.ColorsModel> colors = [];
    if (getProductDet.sizes != null) {
      for (var size in getProductDet.sizes!) {
        sizes.add(home.Sizes(
            size: home.SizeItem(
          id: size.size!.id,
          name: size.size!.name,
        )));
      }
    }

    if (getProductDet.colors != null) {
      for (var color in getProductDet.colors!) {
        colors.add(home.ColorsModel(
            color: home.ColorData(
          id: color.color!.id,
          createdAt: color.color!.createdAt,
          hexCode: color.color!.hexCode,
          name: color.color!.name,
        )));
      }
    }
    return home.Product(
        id: getProductDet.id,
        name: getProductDet.name,
        price: getProductDet.price,
        sizes: sizes,
        colors: colors,
        store: home.Store(
            id: getProductDet.store!.id,
            logo: getProductDet.store!.logo,
            name: getProductDet.store!.name),
        mainImage: getProductDet.mainImage,
        description: getProductDet.description,
        quantity: getProductDet.quantity);
  }

  List<String> formattedSizesList(model.GetProductDetails getProductDet) {
    List<String> sizes = [];
    for (var i = 0; i < getProductDet.sizes!.length; i++) {
      String formattedSize =
          home.SizeItem.mapSize(getProductDet.sizes![i].size!.name!);
      sizes.add(formattedSize);
    }
    return sizes;
  }

  selectSize(model.GetProductDetails product, String size) {
    product.sizeValue = size;
    update();
  }

  quantityCount(model.GetProductDetails product, int count) {
    product.quantity = count;
    update();
  }

  // ========== APIs FUNCTIONS ========== //

  // TODO : Clean up the pagination logic, API calls should be handled by service
  Future<void> getRelatedProductsCall({bool isInitialLoad = false}) async {
    logg.i('Get Related Products call in product description');
    if (isInitialLoad) {
      // Generate a random number between 1 and 15
      // This gives illusion of an ML algorithm
      final randomPage = Random().nextInt(7) +
          1; // nextInt(15) gives 0–7, so +1. There are 182 products in DB right now

      relatedProductsPage.value = randomPage;
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
