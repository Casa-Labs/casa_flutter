// Add items to cart request model //
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

// This model shows items which add in the cart //

class ProductForCart {
  String? id;
  String? name;
  String? description;
  int? price;
  String? category;
  List<dynamic>? size;
  int? stock;
  String? storeId;
  String? mainImage;
  bool? isNewArrival;
  // List<String>? productImages;
  bool? isTrending;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;
  int? quantity;

  ProductForCart(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.category,
      this.size,
      // this.productImages,
      this.mainImage,
      this.stock,
      this.storeId,
      this.isNewArrival,
      this.isTrending,
      this.createdAt,
      this.updatedAt,
      this.quantity});

  ProductForCart.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    if (json['price'] is int) {
      price = json['price'] ?? 0;
    }
    if (json['price'] is double) {
      price = json['price'].round() ?? 0;
    }
    category = json['category'] ?? "";
    mainImage = json['mainImage'] ?? "";
    size = json['sizes'] ?? [];
    // productImages = json['productImages'].cast<String>() ?? [];
    stock = json['stock'] ?? 0;
    storeId = json['storeId'] ?? "";
    isNewArrival = json['isNewArrival'] ?? false;
    isTrending = json['isTrending'] ?? false;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    quantity = json['quantity'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    // data['productImages'] = productImages;
    data['mainImage'] = mainImage;
    data['sizes'] = size;
    data['stock'] = stock;
    data['storeId'] = storeId;
    data['isNewArrival'] = isNewArrival;
    data['isTrending'] = isTrending;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
