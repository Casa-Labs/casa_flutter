import 'dart:math';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:casaflutterapp/src/home/model/service/home_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final ValueNotifier<int> counter = ValueNotifier<int>(1);
  IconData? swipeIcon;
  RxInt reviewStar = 0.obs;

  RxString shareMessage = ''.obs;

  // final List<ProductModelFilter> brandFilter = [
  //   ProductModelFilter(leading: 'Z', title: 'Zara'),
  //   ProductModelFilter(leading: 'H', title: 'H&M'),
  //   ProductModelFilter(leading: 'G', title: 'Gap'),
  //   ProductModelFilter(leading: 'C', title: 'CASA'),
  //   ProductModelFilter(leading: 'T', title: 'Tommy hilfiger')
  // ];
  // final List<ProductModelFilter> productFilter = [
  //   ProductModelFilter(leading: '', title: 'Topwear'),
  //   ProductModelFilter(leading: '', title: 'Shirt'),
  //   ProductModelFilter(leading: '', title: 'Sweatshirt'),
  //   ProductModelFilter(leading: '', title: 'T- shirt'),
  //   ProductModelFilter(leading: '', title: 'Hoodie')
  // ];
  // final List<ProductModelFilter> colorFilter = [
  //   ProductModelFilter(leading: '', title: 'Black'),
  //   ProductModelFilter(leading: '', title: 'Brown'),
  //   ProductModelFilter(leading: '', title: 'Green'),
  //   ProductModelFilter(leading: '', title: 'Denim'),
  //   ProductModelFilter(leading: '', title: 'Zebra print')
  // ];
  // final List<ProductModelFilter> sizedFilter = [
  //   ProductModelFilter(leading: '', title: 'XXS'),
  //   ProductModelFilter(leading: '', title: 'XS'),
  //   ProductModelFilter(leading: '', title: 'S'),
  //   ProductModelFilter(leading: '', title: 'M'),
  //   ProductModelFilter(leading: '', title: 'L'),
  //   ProductModelFilter(leading: '', title: 'XL'),
  //   ProductModelFilter(leading: '', title: 'XXL')
  // ];
  final manager = GraphQLManager();

  // ========== STATES ========== //

  @override
  void onInit() async {
    super.onInit();
    await fetchProducts({});
    await getBrand();
    // await getSize();
    await getCategory();
  }

  // ========== UI FUNCTIONS ========== //

  void onEnd() {
    if (kDebugMode) {
      print('end reached!');
    }

  }

  void addToCartSwipe() {
    swipeIcon = Icons.add_shopping_cart_outlined;
    controller.swipeRight();
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
        if(swipeIcon == Icons.add_shopping_cart_outlined){
        }else {
          if (activity.direction == AxisDirection.right) {
            swipeIcon = Icons.check_rounded; // ✅ Right Swipe
          } else if (activity.direction == AxisDirection.left) {
            swipeIcon = Icons.close_rounded; // ❌ Left Swipe
          }
        }

        // Hide the icon after some time
        if(swipeIcon == Icons.add_shopping_cart_outlined){
          Future.delayed(Duration(milliseconds: 800), () {
            swipeIcon = null;
            update();
          });
        }else {
          Future.delayed(Duration(milliseconds: 500), () {
            swipeIcon = null;
            update();
          });
        }
        update();
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

  List<String> formattedSizesList(Product product) {
    selectedSize.value = SizeItem.mapSize(product.sizes![0].size!.name!);
    List<String> sizes = [];
    for (var i = 0; i < product.sizes!.length; i++) {
      String formattedSize = SizeItem.mapSize(product.sizes![i].size!.name!);
      sizes.add(formattedSize);
    }
    return sizes;
  }

  String formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
    }
  }

// ========== APIs FUNCTIONS ========== //

  Future<void> fetchProducts(Map<String, dynamic> map) async {
    try {
      isLoading.value = true;
      update();
      var response = await manager.getProducts(map);
      var getProductList = GetProductData.fromJson(response.data!);
      products = getProductList.getProducts!.data ?? [];
      products.shuffle(Random());
      isLoading.value = false;
      update();
    } catch (e) {
      logg.e('get error to fetch product data $e');
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
      // Convert API sizes to button format
      formattedSizes =
          size.map((s) => GetProductSizes.mapSize(s.name!)).toList();
      // isLoading.value =  false;
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

  Future<void> getBrand() async {
    try {
      isLoading.value = true;
      update();
      var response = await manager.getBrands(
          limit: 5, page: 1, search: "", storeType: "BRAND");
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
        return "Please, selete the rating!!";
      }
      if (comment.isEmpty) {
        return "Please, write a review!!";
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
        return "Review add successfully!!";
      }
    } catch (e) {
      logg.e("get error to adding review $e");
      update();
      return "Something went wrong, please try again";
    }
    return "Something went wrong, please try again";
  }
}
