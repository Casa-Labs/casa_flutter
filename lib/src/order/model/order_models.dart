class OrderModel {
  Data? data;

  OrderModel({this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<GetOrders>? getOrders;

  Data({this.getOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getOrders'] != null) {
      getOrders = <GetOrders>[];
      json['getOrders'].forEach((v) {
        getOrders!.add(GetOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (getOrders != null) {
      data['getOrders'] = getOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetOrders {
  String? createdAt;
  String? id;
  OrderedProductDetails? orderedProductDetails;
  String? productId;
  ShippingInfo? shippingInfo;
  int? total;
  String? updatedAt;
  String? userId;

  GetOrders(
      {this.createdAt,
        this.id,
        this.orderedProductDetails,
        this.productId,
        this.shippingInfo,
        this.total,
        this.updatedAt,
        this.userId});

  GetOrders.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    orderedProductDetails = json['orderedProductDetails'] != null
        ? OrderedProductDetails.fromJson(json['orderedProductDetails'])
        : null;
    productId = json['productId'];
    shippingInfo = json['shippingInfo'] != null
        ? ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    total = json['total'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['id'] = id;
    if (orderedProductDetails != null) {
      data['orderedProductDetails'] = orderedProductDetails!.toJson();
    }
    data['productId'] = productId;
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    data['total'] = total;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }
}

class OrderedProductDetails {
  String? size;
  String? color;
  int? quantity;

  OrderedProductDetails({this.size, this.color, this.quantity});

  OrderedProductDetails.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    color = json['color'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['color'] = color;
    data['quantity'] = quantity;
    return data;
  }
}

class ShippingInfo {
  String? zip;
  String? city;
  String? state;
  String? address;

  ShippingInfo({this.zip, this.city, this.state, this.address});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    zip = json['zip'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zip'] = zip;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    return data;
  }
}
