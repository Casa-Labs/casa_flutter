import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/src/explore/model/brands_model.dart' as brand;
import 'package:casaflutterapp/src/explore/model/explore_products_model.dart'
    as epm;
import 'package:casaflutterapp/src/explore/model/new_arrivals_model.dart'
    as nam;
import 'package:casaflutterapp/src/explore/model/product_by_id_model.dart'
    as pim;
import 'package:casaflutterapp/src/explore/model/product_categories_model.dart'
    as pcm;
import 'package:casaflutterapp/src/explore/model/service/explore_service.dart';
import 'package:casaflutterapp/src/explore/model/trending_products_model.dart'
    as tpm;
import 'package:casaflutterapp/utils/utils.dart';
import 'package:get/get.dart';

import '../../cart/model/cart_models.dart';

class ExploreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //

  RxInt selectedIndex = 0.obs; // For gender : Men = 0 and Women = 1
  RxList<tpm.Products> trendingProducts = <tpm.Products>[].obs;
  RxList<nam.Products> newArrivalProducts = <nam.Products>[].obs;
  RxList<brand.Data> brands = <brand.Data>[].obs;
  RxList<epm.Data?> clothesYouMightLike = <epm.Data>[].obs;
  RxList<pcm.GetProductCategories> categories =
      <pcm.GetProductCategories>[].obs;

  RxString storeType = 'BRAND'.obs;
  bool isShowReturn = false;
  bool isShowShipping = false;
  // Pagination - temporary calling 100 items
  RxInt page = 1.obs;
  RxInt limit = 30.obs;

  // Related Products ( Products Call) pagination
  RxInt relatedProductsPage = 1.obs;
  RxInt relatedProductsLimit = 20.obs;
  RxBool relatedProductsIsLoadingMore = false.obs;
  RxBool relatedProductsHasMore = true.obs;

  // ========== STATES ========== //

  @override
  void onReady() async {
    super.onReady();
    await getTrendingNowProductsCall();
    await getNewArrivalProductsCall();
    await getBrandsCall();
    await getCategoriesCall();
    await getProductsCall(isInitialLoad: true);
  }

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  Future<void> onRefresh() async {
    await getTrendingNowProductsCall();
    await getNewArrivalProductsCall();
    await getProductsCall(isInitialLoad: true);
  }

  Future<void> getTrendingNowProductsCall() async {
    await ExploreService().getTrendingNowProducts();
  }

  Future<void> getNewArrivalProductsCall() async {
    await ExploreService().getNewArrivalProducts();
  }

  Future<void> getBrandsCall() async {
    await ExploreService().getBrands();
  }

  Future<void> getCategoriesCall() async {
    await ExploreService().getProductCategories();
  }

  Future<CartItem> getProductById(String productId) async {
    return await ExploreService().getProductById(productId);
  }

  Future<pim.GetProductDetails> getProductDetailsByIdCall(
      String productId) async {
    return await ExploreService().getProductDetailsById(productId);
  }

  // Future<void> getProductsCall() async {
  //   await ExploreService().getProductsCall();
  // }

  // TODO : Clean up the pagination logic, API calls should be handled by service
  Future<void> getProductsCall({bool isInitialLoad = false}) async {
    if (isInitialLoad) {
      relatedProductsPage.value = 1;
      relatedProductsHasMore.value = true;
      clothesYouMightLike.clear();
    }

    if (!relatedProductsHasMore.value || relatedProductsIsLoadingMore.value) {
      logg.d(
          "Not fetching: hasMore=${relatedProductsHasMore.value}, isLoading=${relatedProductsIsLoadingMore.value}");
      return;
    }

    relatedProductsIsLoadingMore.value = true;

    // Todo 14-04-2025 : Make Men - Women logic cleaner later

    Map<String, dynamic> getProductVariables = {};

    // Toggle for men or women
    if (selectedIndex.value == 0) {
      getProductVariables = {
        "page": relatedProductsPage.value,
        "pageSize": relatedProductsLimit.value,
        "gender": "MA"
      };
    } else {
      getProductVariables = {
        "page": relatedProductsPage.value,
        "pageSize": relatedProductsLimit.value,
        "gender": "FE"
      };
    }

    var response =
        await GraphQLManager().getProductsForExplore(getProductVariables);

    if (!response.hasException && response.data != null) {
      final productsResponse =
          epm.ExploreGetProductsModel.fromJson(response.data!);
      final newProducts = productsResponse.getProducts?.data ?? [];

      if (newProducts.length < relatedProductsLimit.value) {
        relatedProductsHasMore.value = false;
      }

      clothesYouMightLike.addAll(newProducts);
      relatedProductsPage.value++;
    } else {
      logg.e('Get clothes you might like Exception: ${response.exception}');
    }

    relatedProductsIsLoadingMore.value = false;
  }

  changeShippingPolicy() {
    isShowShipping = !isShowShipping;
    update();
  }

  changeReturnPolicy() {
    isShowReturn = !isShowReturn;
    update();
  }
}
