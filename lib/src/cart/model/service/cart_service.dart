import 'package:casa_flutter/network/graph_ql_manager.dart';
import 'package:casa_flutter/src/cart/model/cart_models.dart';

class CartService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<AddCartResponseModel?> addItemToCart({
    required AddCartRequestModel addCartRequestModel,
  }) async {
    final AddCartResponseModel addCartResponseModel;

    final response = await _graphQLManager.addItemToCart(
      addCartRequestModel.userId,
      addCartRequestModel.items,
    );

    addCartResponseModel = AddCartResponseModel.fromJson(
      response.data,
    );

    return addCartResponseModel;
  }
}
