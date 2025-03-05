class NewArrivalsResponseModel {
  Data? data;

  NewArrivalsResponseModel({this.data});

  NewArrivalsResponseModel.fromJson(Map<String, dynamic> json) {
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
  GetNewArrivalProducts? getNewArrivalProducts;

  Data({this.getNewArrivalProducts});

  Data.fromJson(Map<String, dynamic> json) {
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
  List<String>? productImages;

  Products({this.productImages});

  Products.fromJson(Map<String, dynamic> json) {
    productImages = json['productImages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productImages'] = productImages;
    return data;
  }
}
