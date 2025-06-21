import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:casaflutter/src/home/model/color_model.dart';
import 'package:casaflutter/src/home/model/service/home_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../network/graph_ql_manager.dart';
import '../../../utils/preference_manager.dart';
import '../../../utils/utils.dart';
import '../model/add_review_model.dart';
import '../model/brand_response_model.dart';
import '../model/cat_response_model.dart';
import '../model/home_models.dart';
import '../model/review_response.dart';
import '../model/size_respose_model.dart';

class HomeController extends GetxController {
  // ========= CONTROLLERS ========= //

  final AppinioSwiperController controller = AppinioSwiperController();
  TextEditingController? searchController = TextEditingController();
  TextEditingController? reviewController = TextEditingController();

  // ========= VARIABLES ========= //

  final userID = PreferenceManager.getString(PreferenceManager.userId);
  bool isDisabled = false;
  List<Product> products = [];
  List<GetProductSizes> size = [];

  // Convert API sizes to button format
  List<String> formattedSizes = [];
  List<BrandData> brand = [];
  List<GetProductCategories> category = [];
  RxBool isLoading = false.obs;
  RxList<Product> reactiveProducts = <Product>[].obs;
  bool isShowReturn = false;
  bool isShowShipping = false;
  bool isShowFilter = true;
  var price = ''.obs;
  var title = ''.obs;
  var id = ''.obs;
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;
  int cardIndex = 0;
  int currentIndex = 0;
  int minValue = 0;
  int maxValue = 0;
  RxString selectedSize = "S".obs;
  String itemIdForSize = "";
  final ValueNotifier<int> counter = ValueNotifier<int>(1);
  IconData? swipeIcon;
  RxInt reviewStar = 0.obs;

  RxString shareMessage = ''.obs;
  RxList<GetColors> colors = <GetColors>[].obs;

  final manager = GraphQLManager();

  int currentPage = 1;
  final int pageSize = 10;
  bool isPaginating = false;
  bool noMoreData = false;

  RxString selectedGender = ''.obs;

  RxMap<String, dynamic> filters = {
    "category": null, // String
    "gender": null, // String
    "maxPrice": null, // int
    "minPrice": null, // int
    "productColor": <String>[], // List<String>
    "productSize": <String>[], // List<String>
    "storeIds": <String>[], // List<String>
    "storeType": null // String
  }.obs;

  // ========== STATES ========== //

  @override
  void onInit() async {
    super.onInit();
    await fetchProducts({});
    await getBrand();
    await getSize();
    await getCategory();
    await getColors();
  }

  // ========== UI FUNCTIONS ========== //

  void onEnd() {
    if (kDebugMode) {
      print('end reached!');
    }
  }

  void addToCartSwipe() {
    swipeIcon = Icons.add_shopping_cart_outlined;
    Future.delayed(Duration(milliseconds: 400), () {
      controller.swipeRight();
    });
    update();
  }

  void swipeEnd(int previousIndex, int targetIndex, SwiperActivity activity) {
    cardIndex = targetIndex;
    // price.value = reactiveProducts[targetIndex].price!;
    // title.value = reactiveProducts[targetIndex].title!;
    // id.value = reactiveProducts[targetIndex].id!;
    currentIndex = targetIndex;
    counter.value = 1;
    switch (activity) {
      case Swipe():
        if (kDebugMode) {
          print('The card was swiped to the: ${activity.direction}');
          print('Previous index: $previousIndex, Target index: $targetIndex');
        }
        // Add conditions for swipe directions
        if (swipeIcon == Icons.add_shopping_cart_outlined) {
        } else {
          if (activity.direction == AxisDirection.right) {
            swipeIcon = Icons.check_rounded; // ✅ Right Swipe
          } else if (activity.direction == AxisDirection.left) {
            swipeIcon = Icons.close_rounded; // ❌ Left Swipe
          }
        }

        // Hide the icon after some time
        if (swipeIcon == Icons.add_shopping_cart_outlined) {
          Future.delayed(Duration(milliseconds: 900), () {
            swipeIcon = null;
            update();
          });
        } else {
          Future.delayed(Duration(milliseconds: 500), () {
            swipeIcon = null;
            update();
          });
        }
        // Trigger Pagination Api
        if (targetIndex >= reactiveProducts.length - 2 &&
            !isPaginating &&
            !noMoreData) {
          fetchProducts(getCleanFilters());
        }
        break;

      case Unswipe():
        if (kDebugMode) {
          print('A ${activity.direction.name} swipe was undone.');
          print('Previous index: $previousIndex, Target index: $targetIndex');
        }
        break;

      case CancelSwipe():
        if (kDebugMode) {
          print('A swipe was cancelled');
        }
        break;

      case DrivenActivity():
        if (kDebugMode) {
          print('Driven Activity');
        }
        break;
    }
    update();
  }

  showFilter() {
    isShowFilter = !isShowFilter;
    update();
  }

  changeShippingPolicy() {
    isShowShipping = !isShowShipping;
    update();
  }

  changeReturnPolicy() {
    isShowReturn = !isShowReturn;
    update();
  }

  selectSize(String size) {
    selectedSize.value = size;
    update();
  }

  reviewedStarCount(int count) {
    reviewStar.value = count;
    update();
  }

  quantityCount(Product prodct, int count) {
    prodct.quantity = count;
    update();
  }

  List<String> formattedSizesList() {
    if (itemIdForSize != products[cardIndex].id) {
      selectedSize.value =
          SizeItem.mapSize(products[cardIndex].sizes![0].size!.name!);
      itemIdForSize = products[cardIndex].id!;
    }
    List<String> sizes = [];
    for (var i = 0; i < products[cardIndex].sizes!.length; i++) {
      String formattedSize =
          SizeItem.mapSize(products[cardIndex].sizes![i].size!.name!);
      sizes.add(formattedSize);
    }
    return sizes;
  }

  /// Converts a timestamp string (in milliseconds) to a formatted date string.
  ///
  /// [timestampMillisStr] is the Unix timestamp in milliseconds, passed as a string.
  /// [format] is the desired output format (default: 'yyyy-MM-dd HH:mm:ss').
  /// [isUtc] determines whether to interpret the time in UTC or local.
  String formatTimestamp(String timestampMillisStr,
      {String format = 'dd-MM-yyyy', bool isUtc = false}) {
    try {
      int timestampMillis = int.parse(timestampMillisStr);
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(timestampMillis, isUtc: isUtc);
      return DateFormat(format).format(date);
    } catch (e) {
      return 'Invalid timestamp';
    }
  }

  /// This method ensures you're only passing relevant filters to the backend, cleaning null values
  Map<String, dynamic> getCleanFilters() {
    return Map.fromEntries(
      filters.entries.where((entry) => entry.value != null),
    );
  }

// ========== APIs FUNCTIONS ========== //

  Future<void> fetchProducts(Map<String, dynamic> map,
      {bool reset = false}) async {
    isLoading.value = true;
    if (isPaginating) return;
    if (reset) {
      currentPage = 1;
      noMoreData = false;
      products.clear();
      reactiveProducts.clear();
      update();
    }

    if (noMoreData) {
      isLoading.value = false;
      update();
      return;
    }

    isPaginating = true;
    update();

    try {
      final Map<String, dynamic> finalParams = {
        ...map,
        "page": currentPage,
        "pageSize": pageSize,
      };

      final response = await manager.getProducts(finalParams);
      final getProductList = GetProductData.fromJson(response.data ?? {});
      final newProducts = getProductList.getProducts?.data ?? [];

      if (newProducts.isEmpty) {
        noMoreData = true;
      } else {
        products.addAll(newProducts);
        // products.shuffle(Random());
        reactiveProducts.assignAll(products);
        currentPage++;
      }
    } catch (e) {
      logg.e('Error fetching paginated product data: $e');
    } finally {
      isPaginating = false;
      isLoading.value = false;
      update();
    }
  }

  Future<void> getSize() async {
    try {
      isLoading.value = true;
      update();
      var response = await manager.getSizes();
      var getSizeData = GetSizeData.fromJson(response.data!);
      size = getSizeData.getProductSizes ?? [];
      update();
    } catch (e) {
      logg.e('get error to fetch product data $e');
      isLoading.value = false;
      update();
    }
  }

  Future<void> getCategory() async {
    try {
      isLoading.value = true;
      update();
      var response = await manager.getCategory();
      var catList = GetCategories.fromJson(response.data!);
      category = catList.getProductCategories ?? [];
      logg.d('categories data ------ >>>>> $catList');
      isLoading.value = false;
      update();
    } catch (e) {
      logg.e('get error to fetch product data $e');
      isLoading.value = false;
      update();
    }
  }

  Future<void> getColors() async {
    try {
      isLoading.value = true;
      update();
      var response = await manager.getColors();
      var colorList = GetColorResponseModel.fromJson(response.data!);
      colors.assignAll(colorList.getColors ?? []);
      isLoading.value = false;
      update();
    } catch (e) {
      logg.e('get error to fetch colors data $e');
      isLoading.value = false;
      update();
    }
  }

  Future<void> getBrand() async {
    try {
      isLoading.value = true;
      update();
      var response = await manager.getBrands(
          limit: 100, page: 1, search: "", storeType: "BRAND");
      var brandList = GetBrandData.fromJson(response.data!);
      brand = brandList.getBrands!.data ?? [];
      logg.d('brand data ------ >>>>> $brandList');
      // isLoading.value =  false;
      update();
    } catch (e) {
      logg.e('get error to fetch product data $e');
      isLoading.value = false;
      update();
    }
  }

  Future<GetProductReviewModel?> getReviews(String productId) async {
    return await HomeService().getReview(productId: productId);
  }

  Future<String> registerProductReview(
      String productId, int reviewCount, String comment) async {
    try {
      if (reviewCount == 0) {
        return "Please, select the rating.";
      }
      if (comment.isEmpty) {
        return "Please, write a review.";
      }
      AddReviewRequestModel addReviewRequestModel = AddReviewRequestModel(
          productId: productId,
          userId: userID!,
          liked: reviewCount >= 3,
          disliked: reviewCount < 3,
          viewed: true,
          rating: reviewCount,
          comment: comment);
      var response = await HomeService()
          .registerProductReview(addReviewRRequestModel: addReviewRequestModel);
      if (response != null) {
        getReviews(productId);
        return "Review add successfully.";
      }
    } catch (e) {
      logg.e("get error to adding review $e");
      update();
      return "Something went wrong, please try again.";
    }
    return "Something went wrong, please try again.";
  }
}
