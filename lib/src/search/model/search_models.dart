class SearchProductsResponseModel {
  GetProducts? getProducts;

  SearchProductsResponseModel({this.getProducts});

  SearchProductsResponseModel.fromJson(Map<String, dynamic> json) {
    getProducts = json['getProducts'] != null
        ? GetProducts.fromJson(json['getProducts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getProducts != null) {
      data['getProducts'] = getProducts!.toJson();
    }
    return data;
  }
}

class GetProducts {
  List<Data>? data;

  GetProducts({this.data});

  GetProducts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? storeId;
  Store? store;
  String? name;
  String? description;
  String? categoryId;
  String? category;
  double? price;
  int? stock;
  bool? isNewArrival;
  bool? isTrending;
  String? trendingScore;
  String? variants;
  List<Sizes>? sizes;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  String? reasonToDelete;
  String? gender;
  String? customReturnPolicy;
  String? customShippingPolicy;
  List<String>? productImages;
  String? mainImage;

  Data(
      {this.id,
      this.storeId,
      this.store,
      this.name,
      this.description,
      this.categoryId,
      this.category,
      this.price,
      this.stock,
      this.isNewArrival,
      this.isTrending,
      this.trendingScore,
      this.variants,
      this.sizes,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.reasonToDelete,
      this.gender,
      this.customReturnPolicy,
      this.customShippingPolicy,
      this.productImages,
      this.mainImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    name = json['name'];
    description = json['description'];
    categoryId = json['categoryId'];
    category = json['category'];
    price = json['price'] != null ? (json['price'] as num).toDouble() : 0.0;
    stock = json['stock'];
    isNewArrival = json['isNewArrival'];
    isTrending = json['isTrending'];
    trendingScore = json['trendingScore'];
    variants = json['variants'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDeleted = json['isDeleted'];
    reasonToDelete = json['reasonToDelete'];
    gender = json['gender'];
    customReturnPolicy = json['customReturnPolicy'];
    customShippingPolicy = json['customShippingPolicy'];
    productImages = json['productImages'].cast<String>();
    mainImage = json['mainImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['name'] = name;
    data['description'] = description;
    data['categoryId'] = categoryId;
    data['category'] = category;
    data['price'] = price;
    data['stock'] = stock;
    data['isNewArrival'] = isNewArrival;
    data['isTrending'] = isTrending;
    data['trendingScore'] = trendingScore;
    data['variants'] = variants;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isDeleted'] = isDeleted;
    data['reasonToDelete'] = reasonToDelete;
    data['gender'] = gender;
    data['customReturnPolicy'] = customReturnPolicy;
    data['customShippingPolicy'] = customShippingPolicy;
    data['productImages'] = productImages;
    data['mainImage'] = mainImage;
    return data;
  }
}

class Store {
  String? logo;
  String? name;
  String? id;

  Store({this.logo, this.name, this.id});

  Store.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Sizes {
  Size? size;

  Sizes({this.size});

  Sizes.fromJson(Map<String, dynamic> json) {
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (size != null) {
      data['size'] = size!.toJson();
    }
    return data;
  }
}

class Size {
  String? name;
  String? id;

  Size({this.name, this.id});

  Size.fromJson(Map<String, dynamic> json) {
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
