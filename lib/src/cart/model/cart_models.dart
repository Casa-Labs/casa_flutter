// Add items to cart request model //
import '../../home/model/home_models.dart';

class AddCartRequestModel {
  String userId;
  Map<String, dynamic> item;

  AddCartRequestModel({
    required this.userId,
    required this.item,
  });
}

// Add items to cart response model //
class AddCartResponseModel {
  CartItem? addItemToCart;

  AddCartResponseModel({this.addItemToCart});

  AddCartResponseModel.fromJson(Map<String, dynamic> json) {
    addItemToCart = json['addItemToCart'] != null
        ? CartItem.fromJson(json['addItemToCart'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addItemToCart != null) {
      data['addItemToCart'] = addItemToCart!.toJson();
    }
    return data;
  }
}

// Get cart items request model //
class GetcartRequestModel {
  String userId;

  GetcartRequestModel({
    required this.userId,
  });
}

// Get cart items response model //
class GetCartResponseModel {
  // CartItem? getCartItems;
  List<CartItem>? getCartItems;

  GetCartResponseModel({this.getCartItems});

  GetCartResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['getCartItems'] != null) {
      getCartItems = <CartItem>[];
      json['getCartItems'].forEach((v) {
        getCartItems!.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getCartItems != null) {
      data['getCartItems'] = getCartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// This model is used both get and add cart response model//
class CartItem {
  ProductForCart? item;
  String? id;
  String? createdAt;
  String? updatedAt;

  CartItem({this.item, this.id, this.createdAt, this.updatedAt});

  CartItem.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? ProductForCart.fromJson(json['item']) : null;
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (item != null) {
      data['item'] = item!.toJson();
    }
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

// This model shows items which add com the cart //
class ProductForCart {
  String? productId;
  String? name;
  double? productPrice;
  String? size;
  String? color;
  Store? store;
  String? mainImage;
  String? description;
  String? sizeValue;
  bool? isSelected;
  int? quantity;

  ProductForCart(
      {this.productId,
      this.name,
      this.productPrice,
      this.color,
      this.size,
        this.store,
      this.mainImage,
      this.description,
      this.sizeValue,
      this.quantity});

  ProductForCart.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] ?? "";
    name = json['name'] ?? "";
    productPrice = json['productPrice'] is int
        ? (json['productPrice'] as int).toDouble()
        : (json['productPrice'] ?? 0).toDouble();
    size = json['size'] ?? "";
    color = json['color'] ?? "";
    if (store != null) {
      json['store'] = store?.toJson();
    }
    mainImage = json['mainImage'] ?? "";
    description = json['description'] ?? "";
    sizeValue = json['sizeValue'] ?? "";
    quantity = json["quantity"] is String
        ? int.tryParse(json["quantity"]) ?? 0
        : (json["quantity"] ?? 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['name'] = name;
    data['productPrice'] = productPrice;
    data['mainImage'] = mainImage;
    data['size'] = size;
    data['color'] = color;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['description'] = description;
    data['sizeValue'] = sizeValue;
    data['quantity'] = quantity;
    return data;
  }
}

// remove cart items request model //
class RemoveCartRequestModel {
  String userId;
  String productId;

  RemoveCartRequestModel({
    required this.userId,
    required this.productId,
  });
}

// Update cart items request model //
class UpdateCartRequestModel {
  String userId;
  String productId;
  int quantity;

  UpdateCartRequestModel({
    required this.userId,
    required this.productId,
    required this.quantity,
  });
}
