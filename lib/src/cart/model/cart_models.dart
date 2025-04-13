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
  List<Sizes>? sizes;
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
      this.sizes,
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
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
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
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
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

class Sizes {
  CartSizeItem? size;

  Sizes({this.size});

  Sizes.fromJson(Map<String, dynamic> json) {
    size = json['size'] != null ? CartSizeItem.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (size != null) {
      data['size'] = size!.toJson();
    }
    return data;
  }
}

class CartSizeItem {
  String? id;
  String? name;

  CartSizeItem({this.id, this.name});

  CartSizeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  static String mapSize(String apiSize) {
    switch (apiSize.toLowerCase()) {
      case 'xx-small':
        return 'XXS';
      case 'x-small':
        return 'XS';
      case 'small':
        return 'S';
      case 'medium':
        return 'M';
      case 'large':
        return 'L';
      case 'x-large':
        return 'XL';
      case 'xx-large':
        return 'XXL';
      default:
        return apiSize; // Default fallback
    }
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
