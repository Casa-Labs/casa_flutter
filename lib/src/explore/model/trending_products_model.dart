class TrendingProductsResponseModel {
  GetTrendingProducts? getTrendingProducts;

  TrendingProductsResponseModel({this.getTrendingProducts});

  TrendingProductsResponseModel.fromJson(Map<String, dynamic> json) {
    getTrendingProducts = json['getTrendingProducts'] != null
        ? GetTrendingProducts.fromJson(json['getTrendingProducts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getTrendingProducts != null) {
      data['getTrendingProducts'] = getTrendingProducts!.toJson();
    }
    return data;
  }
}

class GetTrendingProducts {
  int? totalCount;
  List<Products>? products;

  GetTrendingProducts({this.totalCount, this.products});

  GetTrendingProducts.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? mainImage;
  String? id;
  String? name;
  double? price;
  String? description;

  Products({this.mainImage, this.id, this.name, this.price, this.description});

  Products.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    id = json['id'];
    name = json['name'];
    price = (json['price'] != null) ? json['price'].toDouble() : null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainImage'] = mainImage;
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}
