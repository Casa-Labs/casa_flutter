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


class GetProductResModel {
  Data? data;

  GetProductResModel({this.data});

  GetProductResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  GetProducts? getProducts;

  Data({this.getProducts});

  Data.fromJson(Map<String, dynamic> json) {
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
  int? price;
  String? category;
  List<String>? size;
  int? stock;
  String? storeId;
  bool? isNewArrival;
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
        this.size,
        this.stock,
        this.storeId,
        this.isNewArrival,
        this.isTrending,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    size = json['size'].cast<String>();
    stock = json['stock'];
    storeId = json['storeId'];
    isNewArrival = json['isNewArrival'];
    isTrending = json['isTrending'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['size'] = size;
    data['stock'] = stock;
    data['storeId'] = storeId;
    data['isNewArrival'] = isNewArrival;
    data['isTrending'] = isTrending;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
