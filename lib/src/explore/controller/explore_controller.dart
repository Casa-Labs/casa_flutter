import 'package:casaflutterapp/src/explore/model/brands_model.dart' as brand;
import 'package:casaflutterapp/src/explore/model/new_arrivals_model.dart' as nam;
import 'package:casaflutterapp/src/explore/model/product_categories_model.dart'
    as pcm;
import 'package:casaflutterapp/src/explore/model/service/explore_service.dart';
import 'package:casaflutterapp/src/explore/model/trending_products_model.dart'
    as tpm;
import 'package:get/get.dart';

import '../../home/model/home_models.dart';

class ExploreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  final List<ProductModelFilter> brandFilter = [
    ProductModelFilter(leading: '', title: 'Zara'),
    ProductModelFilter(leading: '', title: 'H&M'),
    ProductModelFilter(leading: '', title: 'Gap'),
    ProductModelFilter(leading: '', title: 'CASA'),
    ProductModelFilter(leading: '', title: 'Tommy hilfiger')
  ];
  final List<ProductModelFilter> productFilter = [
    ProductModelFilter(leading: '', title: 'Topwear'),
    ProductModelFilter(leading: '', title: 'Shirt'),
    ProductModelFilter(leading: '', title: 'Sweatshirt'),
    ProductModelFilter(leading: '', title: 'T- shirt'),
    ProductModelFilter(leading: '', title: 'Hoodie')
  ];
  final List<ProductModelFilter> colorFilter = [
    ProductModelFilter(leading: '', title: 'Black'),
    ProductModelFilter(leading: '', title: 'Brown'),
    ProductModelFilter(leading: '', title: 'Green'),
    ProductModelFilter(leading: '', title: 'Denim'),
    ProductModelFilter(leading: '', title: 'Zebra print')
  ];

  final List<ProductModelFilter> sizedFilter = [
    ProductModelFilter(leading: '', title: 'XXS'),
    ProductModelFilter(leading: '', title: 'XS'),
    ProductModelFilter(leading: '', title: 'S'),
    ProductModelFilter(leading: '', title: 'M'),
    ProductModelFilter(leading: '', title: 'L'),
    ProductModelFilter(leading: '', title: 'XL'),
    ProductModelFilter(leading: '', title: 'XXL')
  ];

  RxInt selectedIndex = 0.obs;
  RxList<tpm.Products> trendingProducts = <tpm.Products>[].obs;
  RxList<nam.Products> newArrivalProducts = <nam.Products>[].obs;
  RxList<brand.Data> brands = <brand.Data>[].obs;
  RxList<pcm.GetProductCategories> categories =
      <pcm.GetProductCategories>[].obs;

  RxString storeType = 'BRAND'.obs;

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
  }

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  Future<void> onRefresh() async {
    await getTrendingNowProductsCall();
    await getNewArrivalProductsCall();
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
}
