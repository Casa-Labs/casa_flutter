class ProductModel {
  String? title;
  String? price;
  String? wasPrice;
  Map<String, dynamic>? description;
  List<Images>? images;
  String? url;
  String? id;
  int? selectedColorPosition;
  int? selectedSizePosition;
  int? quantity;
  List<dynamic>? sizes;
  bool? isSelected;

  ProductModel({
    this.title,
    this.price,
    this.wasPrice,
    this.description = const {},
    this.images,
    this.sizes = const [],
    this.id = '',
    this.selectedColorPosition = 0,
    this.selectedSizePosition = 0,
    this.quantity = 1,
    this.url,
    this.isSelected = false,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    price = json['price'] ?? "";
    wasPrice = json['was_price'] ?? "";
    sizes = List<dynamic>.from(json['sizes'] ?? []);
    description = json['description'] is List
        ? {
            for (var item in json['description'])
              item.keys.first: item.values.first
          }
        : {}; // Convert list of key-value pairs to a map;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    id = json['id'] ?? '';
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'was_price': wasPrice,
      'description': description,
      'images': images != null ? images!.map((v) => v.toJson()).toList() : [],
      'url': url,
      'sizes': sizes,
      'id': id
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['was_price'] = wasPrice;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    data['sizes'] = sizes;
    data['id'] = id;
    return data;
  }
}

class Images {
  String? src;
  String? alt;

  Images({this.src, this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['alt'] = alt;
    return data;
  }
}

class GetProductData {
  GetProducts? getProducts;

  GetProductData({this.getProducts});

  GetProductData.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<Product>? data;
  int? total;
  int? totalPages;

  GetProducts({this.currentPage, this.data, this.total, this.totalPages});

  GetProducts.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['totalPages'] = totalPages;
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? description;
  String? customReturnPolicy;
  String? customShippingPolicy;
  double? price;
  String? category;
  String? storeId;
  Store? store;
  List<Sizes>? sizes;
  List<ColorsModel>? colors;
  int? stock;
  String? mainImage;
  bool? isNewArrival;
  List<String>? productImages;
  bool? isTrending;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;
  int? quantity;

  Product(
      {this.id,
      this.name,
      this.description,
      this.customReturnPolicy,
      this.customShippingPolicy,
      this.price,
      this.category,
      this.sizes,
      this.colors,
      this.productImages,
      this.mainImage,
      this.stock,
      this.store,
      this.storeId,
      this.isNewArrival,
      this.isTrending,
      this.createdAt,
      this.updatedAt,
      this.quantity});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    if (store != null) {
      json['store'] = store?.toJson();
    }
    description = json['description'] ?? "";
    if (json['colors'] != null) {
      colors = <ColorsModel>[];
      json['colors'].forEach((v) {
        colors!.add(ColorsModel.fromJson(v));
      });
    }
    customReturnPolicy = json['customReturnPolicy'] ?? "No Policy Found";
    customShippingPolicy = json['customShippingPolicy'] ?? "No Policy Found";
    price = json['price'] is int
        ? (json['price'] as int).toDouble()
        : (json['price'] ?? 0).toDouble();
    category = json['category'] ?? "";
    mainImage = json['mainImage'] ?? "";
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
    productImages = json['productImages'].cast<String>() ?? [];
    stock = json['stock'] ?? 0;
    storeId = json['storeId'] ?? "";
    isNewArrival = json['isNewArrival'] ?? false;
    isTrending = json['isTrending'] ?? false;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    quantity = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['customReturnPolicy'] = customReturnPolicy;
    data['customShippingPolicy'] = customShippingPolicy;
    data['price'] = price;
    data['category'] = category;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['productImages'] = productImages;
    data['mainImage'] = mainImage;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
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

class ProductModelFilter {
  String? title;
  String? leading;
  bool isSelected = false;
  bool isTabView = false;

  ProductModelFilter({this.leading, this.title});
}

class ColorsModel {
  String? productId;
  String? colorId;
  ColorData? color;

  ColorsModel({this.productId, this.colorId, this.color});

  ColorsModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    colorId = json['colorId'];
    color = json['color'] != null ? ColorData.fromJson(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['colorId'] = colorId;
    if (color != null) {
      data['color'] = color!.toJson();
    }
    return data;
  }
}

class ColorData {
  String? id;
  String? name;
  String? hexCode;
  String? createdAt;
  String? updatedAt;

  ColorData({this.id, this.name, this.hexCode, this.createdAt, this.updatedAt});

  ColorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hexCode = json['hexCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['hexCode'] = hexCode;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Sizes {
  SizeItem? size;

  Sizes({this.size});

  Sizes.fromJson(Map<String, dynamic> json) {
    size = json['size'] != null ? SizeItem.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (size != null) {
      data['size'] = size!.toJson();
    }
    return data;
  }
}

class StoreModel {
  Store? store;

  StoreModel({this.store});

  StoreModel.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }
}

class Store {
  String? id;
  String? userId;
  String? name;
  String? description;
  String? type;
  String? logo;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  String? reasonToDelete;

  Store(
      {this.id,
        this.userId,
        this.name,
        this.description,
        this.type,
        this.logo,
        this.createdAt,
        this.updatedAt,
        this.isDeleted,
        this.reasonToDelete});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userId = json['userId'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    type = json['type'] ?? "";
    logo = json['logo'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    isDeleted = json['isDeleted'] ?? "";
    reasonToDelete = json['reasonToDelete'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['logo'] = logo;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isDeleted'] = isDeleted;
    data['reasonToDelete'] = reasonToDelete;
    return data;
  }
}


class SizeItem {
  String? id;
  String? name;

  SizeItem({this.id, this.name});

  SizeItem.fromJson(Map<String, dynamic> json) {
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
