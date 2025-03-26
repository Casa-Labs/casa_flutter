import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/src/cart/model/cart_models.dart';

class CartService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<AddCartResponseModel?> addItemToCart({
    required AddCartRequestModel addCartRequestModel,
  }) async {
    final AddCartResponseModel addCartResponseModel;

    final response = await _graphQLManager.addItemToCart(
      userId: addCartRequestModel.userId,
      items: addCartRequestModel.item,
    );

    addCartResponseModel = AddCartResponseModel.fromJson(
      response.data!,
    );

    return addCartResponseModel;
  }

  Future<GetCartResponseModel?> getCartItems({
    required GetcartRequestModel getCartRequestModel,
  }) async {
    final GetCartResponseModel getCartResponseModel;

    final response = await _graphQLManager.getCartItems(
      userId: getCartRequestModel.userId,
    );

    getCartResponseModel = GetCartResponseModel.fromJson(
      response.data!,
    );

    return getCartResponseModel;
  }

  Future<GetCartResponseModel?> removeItemFromCart({
    required RemoveCartRequestModel removeCartRequestModel,
  }) async {
    final GetCartResponseModel getCartResponseModel;

    final response = await _graphQLManager.removeItemFromCart(
        userId: removeCartRequestModel.userId,
        removeItemFromCartId: removeCartRequestModel.productId);

    getCartResponseModel = GetCartResponseModel.fromJson(
      response.data!,
    );

    return getCartResponseModel;
  }

  Future<GetCartResponseModel?> updateCartItem({
    required UpdateCartRequestModel updateCartRequestModel,
  }) async {
    final GetCartResponseModel getCartResponseModel;

    final response = await _graphQLManager.updateCartItem(
        userId: updateCartRequestModel.userId,
        productId: updateCartRequestModel.productId,
        quantity: updateCartRequestModel.quantity);

    getCartResponseModel = GetCartResponseModel.fromJson(
      response.data!,
    );

    return getCartResponseModel;
  }
}
