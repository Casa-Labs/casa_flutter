class ExploreGetProductsModel {
  GetProducts? getProducts;

  ExploreGetProductsModel({this.getProducts});

  ExploreGetProductsModel.fromJson(Map<String, dynamic> json) {
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
  String? mainImage;
  String? id;

  Data({this.mainImage, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainImage'] = mainImage;
    data['id'] = id;
    return data;
  }
}
