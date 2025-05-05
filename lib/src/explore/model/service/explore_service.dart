import 'package:casaflutter/src/cart/model/cart_models.dart';
import 'package:casaflutter/src/explore/model/brands_model.dart';
import 'package:casaflutter/src/explore/model/explore_products_model.dart';
import 'package:casaflutter/src/explore/model/new_arrivals_model.dart';
import 'package:casaflutter/src/explore/model/product_by_id_model.dart';
import 'package:casaflutter/src/explore/model/product_categories_model.dart';
import 'package:casaflutter/src/explore/model/trending_products_model.dart';
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
      final categoriesResponse = CartItem.fromJson(response.data!);
      return categoriesResponse;
    } else {
      logg.e('Get product by ID Exception: ${response.exception}');
      return CartItem();
    }
  }

  Future<GetProductDetails> getProductDetailsById(String productId) async {
    var response = await GraphQLManager().getProductsById(productId);

    if (!response.hasException && response.data != null) {
      var responseBody = GetProductByIdResponseModel.fromJson(response.data!);
      final productDetailsResponse =
          responseBody.getProductDetails ?? GetProductDetails();
      return productDetailsResponse;
    } else {
      logg.e('Get product details by ID Exception: ${response.exception}');
      return GetProductDetails();
    }
  }

  Future<void> getProducts({
    required int page,
    required int limit,
  }) async {
    var response = await GraphQLManager().getProductsForExplore({
      "page": page,
      "pageSize": limit,
    });

    if (!response.hasException && response.data != null) {
      final productsResponse = ExploreGetProductsModel.fromJson(response.data!);
      exploreCtrl.clothesYouMightLike
          .assignAll(productsResponse.getProducts?.data ?? []);
    } else {
      logg.e('Get clothes you might like Exception: ${response.exception}');
    }
  }
}
