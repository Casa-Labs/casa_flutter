class GetCategoriesResponseModel {
  List<GetProductCategories>? getProductCategories;

  GetCategoriesResponseModel({this.getProductCategories});

  GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? name;
  String? thumbnail;

  GetProductCategories({this.id, this.name, this.thumbnail});

  GetProductCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
