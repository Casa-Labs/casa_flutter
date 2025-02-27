class AddCartRequestModel {
  String userId;
  Map<String, dynamic> items;

  AddCartRequestModel({
    required this.userId,
    required this.items,
  });
}

class AddCartResponseModel {
  Data? data;

  AddCartResponseModel({this.data});

  AddCartResponseModel.fromJson(Map<String, dynamic>? json) {
    data = json?['data'] != null ? Data.fromJson(json?['data']) : null;
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
  AddItemToCart? addItemToCart;

  Data({this.addItemToCart});

  Data.fromJson(Map<String, dynamic> json) {
    addItemToCart = json['addItemToCart'] != null
        ? AddItemToCart.fromJson(json['addItemToCart'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addItemToCart != null) {
      data['addItemToCart'] = addItemToCart!.toJson();
    }
    return data;
  }
}

class AddItemToCart {
  String? createdAt;
  String? id;
  String? items;
  String? updatedAt;
  String? userId;

  AddItemToCart(
      {this.createdAt, this.id, this.items, this.updatedAt, this.userId});

  AddItemToCart.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    items = json['items'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['items'] = items;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}
