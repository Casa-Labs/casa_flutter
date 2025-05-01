class GetStoreInventoryResponseModel {
  List<GetStoreInventory>? getStoreInventory;

  GetStoreInventoryResponseModel({this.getStoreInventory});

  GetStoreInventoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['getStoreInventory'] != null) {
      getStoreInventory = <GetStoreInventory>[];
      json['getStoreInventory'].forEach((v) {
        getStoreInventory!.add(GetStoreInventory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getStoreInventory != null) {
      data['getStoreInventory'] =
          getStoreInventory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetStoreInventory {
  Product? product;

  GetStoreInventory({this.product});

  GetStoreInventory.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? mainImage;
  String? name;
  String? id;
  double? price;
  Store? store;

  Product({this.mainImage, this.name, this.id, this.price, this.store});

  Product.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    name = json['name'];
    id = json['id'];
    // Safely convert price to double
    if (json['price'] != null) {
      price = json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] is double
              ? json['price']
              : double.tryParse(json['price'].toString());
    }
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainImage'] = mainImage;
    data['name'] = name;
    data['id'] = id;
    data['price'] = price;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }
}

class Store {
  String? name;
  String? logo;

  Store({this.name, this.logo});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}
