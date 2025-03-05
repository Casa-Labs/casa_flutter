class ProductCategoriesResponseModel {
  Data? data;

  ProductCategoriesResponseModel({this.data});

  ProductCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<GetProductCategories>? getProductCategories;

  Data({this.getProductCategories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getProductCategories'] != null) {
      getProductCategories = <GetProductCategories>[];
      json['getProductCategories'].forEach((v) {
        getProductCategories!.add(GetProductCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.getProductCategories != null) {
      data['getProductCategories'] =
          this.getProductCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetProductCategories {
  String? name;

  GetProductCategories({this.name});

  GetProductCategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    return data;
  }
}
