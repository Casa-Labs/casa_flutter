class GetProductByIdResponseModel {
  GetProductDetails? getProductDetails;

  GetProductByIdResponseModel({this.getProductDetails});

  GetProductByIdResponseModel.fromJson(Map<String, dynamic> json) {
    getProductDetails = json['getProductDetails'] != null
        ? GetProductDetails.fromJson(json['getProductDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getProductDetails != null) {
      data['getProductDetails'] = getProductDetails!.toJson();
    }
    return data;
  }
}

class GetProductDetails {
  List<String>? productImages;
  String? mainImage;
  String? name;
  double? price;
  List<Colors>? colors;
  List<Sizes>? sizes;
  String? description;
  String? customReturnPolicy;
  String? customShippingPolicy;
  String? categoryId;
  String? id;
  Store? store;
  int? quantity;
  String? sizeValue;

  GetProductDetails(
      {this.productImages,
      this.mainImage,
      this.name,
      this.price,
      this.colors,
      this.sizes,
      this.description,
      this.customReturnPolicy,
      this.customShippingPolicy,
      this.categoryId,
      this.id,
      this.store,
      this.quantity,
      this.sizeValue});

  GetProductDetails.fromJson(Map<String, dynamic> json) {
    productImages = json['productImages'] != null
        ? List<String>.from(json['productImages'])
        : null;
    mainImage = json['mainImage'];
    name = json['name'];
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : json['price'];
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(Colors.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
    description = json['description'];
    customReturnPolicy = json['customReturnPolicy'];
    customShippingPolicy = json['customShippingPolicy'];
    categoryId = json['categoryId'];
    id = json['id'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    quantity = 1;
    sizeValue = "S";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productImages'] = productImages;
    data['mainImage'] = mainImage;
    data['name'] = name;
    data['price'] = price;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['customReturnPolicy'] = customReturnPolicy;
    data['customShippingPolicy'] = customShippingPolicy;
    data['categoryId'] = categoryId;
    data['id'] = id;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['quantity'] = quantity;
    data['sizeValue'] = sizeValue;
    return data;
  }
}

class Colors {
  Color? color;

  Colors({this.color});

  Colors.fromJson(Map<String, dynamic> json) {
    color = json['color'] != null ? Color.fromJson(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (color != null) {
      data['color'] = color!.toJson();
    }
    return data;
  }
}

class Color {
  String? id;
  String? hexCode;
  String? createdAt;
  String? name;

  Color({this.id, this.hexCode, this.createdAt, this.name});

  Color.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hexCode = json['hexCode'];
    createdAt = json['createdAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hexCode'] = hexCode;
    data['createdAt'] = createdAt;
    data['name'] = name;
    return data;
  }
}

class Sizes {
  String? productId;
  String? sizeId;
  Size? size;

  Sizes({this.productId, this.sizeId, this.size});

  Sizes.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    sizeId = json['sizeId'];
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['sizeId'] = sizeId;
    if (size != null) {
      data['size'] = size!.toJson();
    }
    return data;
  }
}

class Size {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Size({this.id, this.name, this.createdAt, this.updatedAt});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Store {
  String? id;
  String? name;
  String? logo;

  Store({this.id, this.name, this.logo});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}
