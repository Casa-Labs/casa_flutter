import 'package:casaflutterapp/src/cart/model/cart_models.dart';
import 'package:casaflutterapp/src/explore/model/brands_model.dart';
import 'package:casaflutterapp/src/explore/model/new_arrivals_model.dart';
import 'package:casaflutterapp/src/explore/model/product_categories_model.dart';
import 'package:casaflutterapp/src/explore/model/trending_products_model.dart';
import 'package:get/get.dart';

import '../../../../network/graph_ql_manager.dart';
import '../../../../utils/utils.dart';
import '../../controller/explore_controller.dart';

class ExploreService {
  final exploreCtrl = Get.find<ExploreController>();

  Future<void> getTrendingNowProducts({String? search}) async {
    var response = await GraphQLManager()
        .getTrendingProducts(exploreCtrl.page(), exploreCtrl.limit(), search);

    if (!response.hasException && response.data != null) {
      final trendingProductsResponse =
          TrendingProductsResponseModel.fromJson(response.data!);
      exploreCtrl.trendingProducts.assignAll(
          trendingProductsResponse.getTrendingProducts?.products ?? []);
    } else {
      logg.e('Get trending products Exception: ${response.exception}');
    }
  }

  Future<void> getNewArrivalProducts({String? search}) async {
    var response = await GraphQLManager().getNewArrivalProductsForExplore(
        exploreCtrl.page(), exploreCtrl.limit(), search);

    if (!response.hasException && response.data != null) {
      final newArrivalsResponse =
          NewArrivalsProductsResponseModel.fromJson(response.data!);
      exploreCtrl.newArrivalProducts
          .assignAll(newArrivalsResponse.getNewArrivalProducts?.products ?? []);
    } else {
      logg.e('Get New arrival products Exception: ${response.exception}');
    }
  }

  Future<void> getBrands({String? search}) async {
    var response = await GraphQLManager().getBrands(
      page: exploreCtrl.page(),
      limit: exploreCtrl.limit(),
      search: search,
      storeType: exploreCtrl.storeType(),
    );

    if (!response.hasException && response.data != null) {
      final brandsResponse = GetBrandsResponseModel.fromJson(response.data!);
      exploreCtrl.brands.assignAll(brandsResponse.getBrands?.data ?? []);
    } else {
      logg.e('Get brands Exception: ${response.exception}');
    }
  }

  Future<void> getProductCategories({String? search}) async {
    var response = await GraphQLManager().getCategory();

    if (!response.hasException && response.data != null) {
      final categoriesResponse =
          GetCategoriesResponseModel.fromJson(response.data!);
      exploreCtrl.categories
          .assignAll(categoriesResponse.getProductCategories ?? []);
    } else {
      logg.e('Get brands Exception: ${response.exception}');
    }
  }

  Future<CartItem> getProductById(String productId) async {
    var response = await GraphQLManager().getProductsById(productId);

    if (!response.hasException && response.data != null) {
      final categoriesResponse =
      CartItem.fromJson(response.data!);
      return categoriesResponse;
    } else {
      logg.e('Get brands Exception: ${response.exception}');
      return CartItem();
    }
  }

}
