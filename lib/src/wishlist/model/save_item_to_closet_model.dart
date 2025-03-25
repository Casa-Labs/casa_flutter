class SaveItemToClosetRequestModel {
  String clothingItemId;
  String productId;

  SaveItemToClosetRequestModel({
    required this.clothingItemId,
    required this.productId,
  });
}

class SaveItemToClosetResponseModel {
  SaveItem? saveItem;

  SaveItemToClosetResponseModel({this.saveItem});

  SaveItemToClosetResponseModel.fromJson(Map<String, dynamic> json) {
    saveItem =
        json['saveItem'] != null ? SaveItem.fromJson(json['saveItem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (saveItem != null) {
      data['saveItem'] = saveItem!.toJson();
    }
    return data;
  }
}

class GetSavedItemsToClosetRequestModel {
  String clothingItemId;
  String userId;

  GetSavedItemsToClosetRequestModel({
    required this.clothingItemId,
    required this.userId,
  });
}

class GetSavedItemsToClosetResponseModel {
  List<SaveItem>? getSavedItems;

  GetSavedItemsToClosetResponseModel({this.getSavedItems});

  GetSavedItemsToClosetResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['getSavedItems'] != null) {
      getSavedItems = <SaveItem>[];
      json['getSavedItems'].forEach((v) {
        getSavedItems!.add(SaveItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSavedItems != null) {
      data['getSavedItems'] = getSavedItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaveItem {
  ClothingItem? clothingItem;
  User? user;
  String? id;
  String? createdAt;
  Product? product;

  SaveItem(
      {this.clothingItem, this.user, this.id, this.createdAt, this.product});

  SaveItem.fromJson(Map<String, dynamic> json) {
    clothingItem = json['clothingItem'] != null
        ? ClothingItem.fromJson(json['clothingItem'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    id = json['id'];
    createdAt = json['createdAt'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clothingItem != null) {
      data['clothingItem'] = clothingItem!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['id'] = id;
    data['createdAt'] = createdAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class ClothingItem {
  String? name;
  String? imageUrl;
  String? id;
  String? createdAt;

  ClothingItem({this.name, this.imageUrl, this.id, this.createdAt});

  ClothingItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    data['createdAt'] = createdAt;
    return data;
  }
}

class User {
  String? name;
  String? id;

  User({this.name, this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Product {
  String? mainImage;
  String? gender;
  String? id;
  String? name;
  String? description;
  double? price;
  List<String>? productImages;
  bool? isSelected;

  Product({
    this.mainImage,
    this.gender,
    this.id,
    this.name,
    this.description,
    this.price,
    this.productImages,
    this.isSelected = false,
  });

  Product.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['price'] is double) {
      price = json['price'];
    } else {
      price = double.parse(json['price'].toString());
    }
    productImages = json['productImages'].cast<String>();
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainImage'] = mainImage;
    data['gender'] = gender;
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['productImages'] = productImages;
    return data;
  }
}

class RemoveClothingItemRequestModel {
  String itemId;

  RemoveClothingItemRequestModel({
    required this.itemId,
  });
}

class RemoveClothingItemResponseModel {
  bool? removeItemFromClothingItem;

  RemoveClothingItemResponseModel({this.removeItemFromClothingItem});

  RemoveClothingItemResponseModel.fromJson(Map<String, dynamic> json) {
    removeItemFromClothingItem = json['removeItemFromClothingItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['removeItemFromClothingItem'] = removeItemFromClothingItem;
    return data;
  }
}
