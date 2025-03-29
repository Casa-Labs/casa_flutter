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
  double? price;
  String? category;
  // List<String>? size;
  List<ColorsModel>? colors;
  int? stock;
  String? storeId;
  String? mainImage;
  bool? isNewArrival;
  List<String>? productImages;
  bool? isTrending;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.category,
      // this.size,
        this.colors,
      this.productImages,
      this.mainImage,
      this.stock,
      this.storeId,
      this.isNewArrival,
      this.isTrending,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    if (json['colors'] != null) {
      colors = <ColorsModel>[];
      json['colors'].forEach((v) {
        colors!.add(ColorsModel.fromJson(v));
      });
    }
    price = json['price'] is int
        ? (json['price'] as int).toDouble()
        : (json['price'] ?? 0).toDouble();
    category = json['category'] ?? "";
    mainImage = json['mainImage'] ?? "";
    // size = json['sizes'] ?? [];
    productImages = json['productImages'].cast<String>() ?? [];
    stock = json['stock'] ?? 0;
    storeId = json['storeId'] ?? "";
    isNewArrival = json['isNewArrival'] ?? false;
    isTrending = json['isTrending'] ?? false;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['productImages'] = productImages;
    data['mainImage'] = mainImage;
    // data['sizes'] = size;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    data['stock'] = stock;
    data['storeId'] = storeId;
    data['isNewArrival'] = isNewArrival;
    data['isTrending'] = isTrending;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
