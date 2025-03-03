class SizeResponse {
  GetSizeData? data;

  SizeResponse({this.data});

  SizeResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? GetSizeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetSizeData {
  List<GetProductSizes>? getProductSizes;

  GetSizeData({this.getProductSizes});

  GetSizeData.fromJson(Map<String, dynamic> json) {
    if (json['getProductSizes'] != null) {
      getProductSizes = <GetProductSizes>[];
      json['getProductSizes'].forEach((v) {
        getProductSizes!.add(GetProductSizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getProductSizes != null) {
      data['getProductSizes'] =
          getProductSizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetProductSizes {
  String? name;
  String? id;

  GetProductSizes({this.name, this.id});

  GetProductSizes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
