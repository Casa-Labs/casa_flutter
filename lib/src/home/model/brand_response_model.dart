class BrandResponse {
  BrandData? data;

  BrandResponse({this.data});

  BrandResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? BrandData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetBrandData {
  GetBrands? getBrands;

  GetBrandData({this.getBrands});

  GetBrandData.fromJson(Map<String, dynamic> json) {
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
  List<BrandData>? data;
  int? total;
  int? totalPages;
  int? currentPage;

  GetBrands({this.data, this.total, this.totalPages, this.currentPage});

  GetBrands.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BrandData>[];
      json['data'].forEach((v) {
        data!.add(BrandData.fromJson(v));
      });
    }
    total = json['total'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    return data;
  }
}

class BrandData {
  String? type;
  String? description;
  String? id;
  bool? isDeleted;
  String? logo;
  String? name;
  String? createdAt;

  BrandData(
      {this.type,
        this.description,
        this.id,
        this.isDeleted,
        this.logo,
        this.name,
        this.createdAt});

  BrandData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    logo = json['logo'];
    name = json['name'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['description'] = description;
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['logo'] = logo;
    data['name'] = name;
    data['createdAt'] = createdAt;
    return data;
  }
}
