class GetBrandsResponseModel {
  GetBrands? getBrands;

  GetBrandsResponseModel({this.getBrands});

  GetBrandsResponseModel.fromJson(Map<String, dynamic> json) {
    getBrands = json['getBrands'] != null
        ? GetBrands.fromJson(json['getBrands'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getBrands != null) {
      data['getBrands'] = getBrands!.toJson();
    }
    return data;
  }
}

class GetBrands {
  List<Data>? data;

  GetBrands({this.data});

  GetBrands.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? name;
  String? id;
  String? logo;

  Data({this.description, this.name, this.id, this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
    id = json['id'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['name'] = name;
    data['id'] = id;
    data['logo'] = logo;
    return data;
  }
}
