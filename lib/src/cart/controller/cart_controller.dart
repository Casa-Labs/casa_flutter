import 'package:casa_flutter/src/cart/model/cart_models.dart';
import 'package:casa_flutter/src/cart/model/service/cart_service.dart';
import 'package:get/get.dart';

import '../../../network/graph_ql_manager.dart';
import '../../../utils/preference_manager.dart';
import '../../home/model/home_models.dart';

class CartController extends GetxController {
  // ========= OBJECTS ============= //
  final CartService _cartService = CartService();

  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  RxList<ProductModel> cartList = <ProductModel>[].obs;
  final userID = PreferenceManager.getString(PreferenceManager.userId);

  final manager = GraphQLManager();

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  Future<void> addProductsToCart(Product product) async {
    AddCartRequestModel addCartRequestModel = AddCartRequestModel(
      userId: userID.toString(),
      items: product.toJson(),
    );
    var response = await _cartService.addItemToCart(
        addCartRequestModel: addCartRequestModel);
  }
}
