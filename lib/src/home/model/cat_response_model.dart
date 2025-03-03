class CategoryResponse {
  GetCategories? data;

  CategoryResponse({this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? GetCategories.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetCategories {
  List<GetProductCategories>? getProductCategories;

  GetCategories({this.getProductCategories});

  GetCategories.fromJson(Map<String, dynamic> json) {
    if (json['getProductCategories'] != null) {
      getProductCategories = <GetProductCategories>[];
      json['getProductCategories'].forEach((v) {
        getProductCategories!.add(GetProductCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getProductCategories != null) {
      data['getProductCategories'] =
          getProductCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetProductCategories {
  String? name;
  Null thumbnail;
  String? id;

  GetProductCategories({this.name, this.thumbnail, this.id});

  GetProductCategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnail = json['thumbnail'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['id'] = id;
    return data;
  }
}
