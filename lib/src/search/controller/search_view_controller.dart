import 'dart:async';

import 'package:casaflutter/src/search/model/search_models.dart' as searchModel;
import 'package:casaflutter/src/search/model/service/search_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  // ========= CONTROLLERS ========= //

  final searchCtrl = TextEditingController();

  // ========= VARIABLES ========= //
  final focusNode = FocusNode();
  Timer? _debounce;

  RxList<searchModel.Data> productsList = <searchModel.Data>[].obs;

  // ========== STATES ========== //

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () {
      focusNode.requestFocus();
    });
  }

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
      searchProductsCall(searchText: value); // Call API after 650ms
    });
  }

  // ========== APIs FUNCTIONS ========== //

  Future<void> searchProductsCall({required String searchText}) async {
    await SearchService().searchProducts(searchText: searchText);
  }
}
