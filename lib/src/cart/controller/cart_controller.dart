import 'package:casaflutterapp/src/cart/model/cart_models.dart';
import 'package:casaflutterapp/src/cart/model/service/cart_service.dart';
import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
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
  RxList<CartItem> cartList = <CartItem>[].obs;
  final userID = PreferenceManager.getString(PreferenceManager.userId);
  GetCartResponseModel getCartResponseModel = GetCartResponseModel();
  final manager = GraphQLManager();
  RxString message = ''.obs;
  bool isLoading = true;
  RxDouble totalPrice = 0.0.obs;

  // ========== STATES ========== //
  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  // ========== UI FUNCTIONS ========== //
  void removeAllItemFromCart() {
    for (var i = 0; i < cartList.length; i++) {
      removeItemFromCart(cartList[i].id.toString());
    }
  }

  void totalPriceCount() {
    double total = 0;
    for (var i = 0; i < cartList.length; i++) {
      total += cartList[i].item!.productPrice! * cartList[i].item!.quantity!;
    }
    totalPrice(double.parse(total.toStringAsFixed(2)));
    update();
  }

  // ========== APIs FUNCTIONS ========== //

  // Add data to cart //
  Future<void> addProductsToCart(
      Product product, int quantity, String selectedSize) async {
    String sizeID = "";
    for (var sizes in product.sizes!) {
      if (selectedSize == SizeItem.mapSize(sizes.size!.name!)) {
        sizeID = sizes.size!.id!;
      }
    }

    Map<String, dynamic> item = {
      "productId": product.id,
      "name": product.name,
      "productPrice": product.price,
      "mainImage": product.mainImage,
      "color": product.colors!.first.color!.id,
      "size": sizeID,
      "sizeValue": selectedSize,
      "description": product.description,
      "sizes": product.sizes,
      "quantity": quantity, // Add quantity field
      // ...product.toJson(), // Convert product to JSON
      // "quantity": quantity, // Add quantity field
    };

    logg.d(item);

    AddCartRequestModel addCartRequestModel = AddCartRequestModel(
      userId: userID!,
      item: item,
    );
    try {
      var response = await _cartService.addItemToCart(
          addCartRequestModel: addCartRequestModel);
      if (response != null) {
        getCartItems();
      }

      showToast(
        message: "Added to the cart!!",
      );
      logg.i('Added to the cart');
    } catch (e) {
      showToast(
        message: "Something went wrong, please try again",
      );
    }
    update();
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
      if (response != null) {
        getCartResponseModel = response;
        cartList(getCartResponseModel.getCartItems ?? []);
        totalPriceCount();
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
      update();
      var response = await _cartService.removeItemFromCart(
          removeCartRequestModel: removeCartRequestModel);
      logg.d("remove Data ====> $response");
      if (response != null) {
        getCartItems();
      }
      update();
    } catch (e) {
      logg.e('get error to remove cart data $e');
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
      update();
      var response = await _cartService.updateCartItem(
          updateCartRequestModel: updateCartRequestModel);
      logg.d("update Data ====> $response");
      if (response != null) {
        getCartItems();
      }
      update();
    } catch (e) {
      logg.e('get error to fetch cart data $e');
      update();
    }
  }
}
