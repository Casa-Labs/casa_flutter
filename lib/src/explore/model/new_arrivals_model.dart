class NewArrivalsProductsResponseModel {
  GetNewArrivalProducts? getNewArrivalProducts;

  NewArrivalsProductsResponseModel({this.getNewArrivalProducts});

  NewArrivalsProductsResponseModel.fromJson(Map<String, dynamic> json) {
    getNewArrivalProducts = json['getNewArrivalProducts'] != null
        ? GetNewArrivalProducts.fromJson(json['getNewArrivalProducts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getNewArrivalProducts != null) {
      data['getNewArrivalProducts'] = getNewArrivalProducts!.toJson();
    }
    return data;
  }
}

class GetNewArrivalProducts {
  int? totalCount;
  List<Products>? products;

  GetNewArrivalProducts({this.totalCount, this.products});

  GetNewArrivalProducts.fromJson(Map<String, dynamic> json) {
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
  int? price;
  String? description;

  Products({this.mainImage, this.id, this.name, this.price, this.description});

  Products.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
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
