import 'dart:async';

import 'package:casaflutter/src/search/model/search_models.dart' as searchModel;
import 'package:casaflutter/src/search/model/service/search_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  // ========= CONTROLLERS ========= //

  final searchCtrl = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // ========= VARIABLES ========= //
  final focusNode = FocusNode();
  Timer? _debounce;
  int currentPage = 1;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;

  RxList<searchModel.Data> productsList = <searchModel.Data>[].obs;

  // ========== STATES ========== //

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () {
      focusNode.requestFocus();
    });
    // scrollController.addListener(() {
    //   loadMoreIfNeeded(scrollController, "");
    // });
  }
  //
  // void loadMoreIfNeeded(ScrollController scrollCtrl, String searchText) {
  //   if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent - 200) {
  //     if (!isLoading.value && !isLastPage.value) {
  //       currentPage++;
  //       searchProductsCall(
  //         searchText: searchText,
  //         currentPage: currentPage,
  //       );
  //     }
  //   }
  // }

  @override
  void onClose() {
    searchCtrl.dispose();
    focusNode.dispose();
    super.onClose();
  }

  // ========== UI FUNCTIONS ========== //

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel(); // Cancel previous timer
    }

    _debounce = Timer(Duration(milliseconds: 650), () {
      searchProductsCall(searchText: value,currentPage: 1); // Call API after 650ms
    });
  }

  // ========== APIs FUNCTIONS ========== //

  Future<void> searchProductsCall({required String searchText,required int currentPage}) async {
    final Map<String, dynamic> finalParams = {
      "search": searchText,
      "page": currentPage,
      "pageSize": 10,
    };
    await SearchService().searchProducts(finalParams);
  }
}
