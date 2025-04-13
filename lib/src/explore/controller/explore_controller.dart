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
import 'package:get/get.dart';

import '../../cart/model/cart_models.dart';

class ExploreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //

  RxInt selectedIndex = 0.obs;
  RxList<tpm.Products> trendingProducts = <tpm.Products>[].obs;
  RxList<nam.Products> newArrivalProducts = <nam.Products>[].obs;
  RxList<brand.Data> brands = <brand.Data>[].obs;
  RxList<epm.Data> clothesYouMightLike = <epm.Data>[].obs;
  RxList<pcm.GetProductCategories> categories =
      <pcm.GetProductCategories>[].obs;

  RxString storeType = 'BRAND'.obs;
  bool isShowReturn = false;
  bool isShowShipping = false;
  // Pagination - temporary calling 100 items
  RxInt page = 1.obs;
  RxInt limit = 100.obs;

  // ========== STATES ========== //

  @override
  void onReady() async {
    super.onReady();
    await getTrendingNowProductsCall();
    await getNewArrivalProductsCall();
    await getBrandsCall();
    await getCategoriesCall();
    await getProductsCall();
  }

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  Future<void> onRefresh() async {
    await getTrendingNowProductsCall();
    await getNewArrivalProductsCall();
    await getProductsCall();
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

  Future<void> getProductsCall() async {
    await ExploreService().getProductsCall();
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
