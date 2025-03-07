import 'package:casa_flutter/src/cart/model/cart_models.dart';
import 'package:casa_flutter/src/cart/model/service/cart_service.dart';
import 'package:get/get.dart';

import '../../../network/graph_ql_manager.dart';
import '../../../utils/preference_manager.dart';
import '../../../utils/utils.dart';
import '../../home/model/home_models.dart';

class CartController extends GetxController {
  // ========= OBJECTS ============= //
  final CartService _cartService = CartService();

  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  RxList<ProductForCart> cartList = <ProductForCart>[].obs;
  final userID = PreferenceManager.getString(PreferenceManager.userId);
  GetCartResponseModel getCartResponseModel = GetCartResponseModel();
  final manager = GraphQLManager();
  RxString message = ''.obs;
  bool isLoading = true;

  // ========== STATES ========== //
  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //
  
  // Add data to cart //
  Future<void> addProductsToCart(Product product, int quantity) async {
    List<Map<String, dynamic>> items = [
      {
        ...product.toJson(), // Convert product to JSON
        "quantity": quantity, // Add quantity field
      }
    ];

    logg.d(items);

    AddCartRequestModel addCartRequestModel = AddCartRequestModel(
      userId: userID!,
      items: items,
    );

    var response = await _cartService.addItemToCart(
        addCartRequestModel: addCartRequestModel);

    logg.d("add Data ====> $response");
  }

  // fetch data for cart //

  Future<void> getCartItems() async {
    GetcartRequestModel getCartRequestModel = GetcartRequestModel(
      userId: userID!,
    );
    try {
      isLoading = true;
      update();
      var response = await _cartService.getCartItems(
          getCartRequestModel: getCartRequestModel);
      logg.d("get Data ====> $response");
      if (response != null && response.getCartItems != null) {
        getCartResponseModel = response;
        cartList(getCartResponseModel.getCartItems!.items ?? []);
      }
      isLoading = false;
      update();
    } catch (e) {
      logg.e('get error to fetch cart data $e');
      isLoading = false;
      update();
    }
  }

  Future<void> removeItemFromCart(String productId) async {
    RemoveCartRequestModel removeCartRequestModel = RemoveCartRequestModel(
      userId: userID!,
      productId: productId,
    );
    try {
      isLoading = true;
      update();
      var response = await _cartService.removeItemFromCart(
          removeCartRequestModel: removeCartRequestModel);
      logg.d("remove Data ====> $response");
      if (response != null && response.getCartItems != null) {
        getCartResponseModel = response;
        cartList(getCartResponseModel.getCartItems!.items ?? []);
      }
      isLoading = false;
      update();
    } catch (e) {
      logg.e('get error to fetch cart data $e');
      isLoading = false;
      update();
    }
  }

  Future<void> updateCartItem(String productId, int quantity) async {
    UpdateCartRequestModel updateCartRequestModel = UpdateCartRequestModel(
      userId: userID!,
      productId: productId,
      quantity: quantity,
    );
    try {
      isLoading = true;
      update();
      var response = await _cartService.updateCartItem(
          updateCartRequestModel: updateCartRequestModel);
      logg.d("update Data ====> $response");
      if (response != null && response.getCartItems != null) {
        getCartResponseModel = response;
        cartList(getCartResponseModel.getCartItems!.items ?? []);
      }
      isLoading = false;
      update();
    } catch (e) {
      logg.e('get error to fetch cart data $e');
      isLoading = false;
      update();
    }
  }
}
