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
    saveItem = json['saveItem'] != null
        ? SaveItem.fromJson(json['saveItem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (saveItem != null) {
      data['saveItem'] = saveItem!.toJson();
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

  Product(
      {this.mainImage,
      this.gender,
      this.id,
      this.name,
      this.description,
      this.price,
      this.productImages});

  Product.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    productImages = json['productImages'].cast<String>();
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
