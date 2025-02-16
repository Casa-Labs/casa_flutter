class OrderModel {
  Data? data;

  OrderModel({this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
        getOrders!.add(new GetOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.getOrders != null) {
      data['getOrders'] = this.getOrders!.map((v) => v.toJson()).toList();
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
        ? new OrderedProductDetails.fromJson(json['orderedProductDetails'])
        : null;
    productId = json['productId'];
    shippingInfo = json['shippingInfo'] != null
        ? new ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    total = json['total'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    if (this.orderedProductDetails != null) {
      data['orderedProductDetails'] = this.orderedProductDetails!.toJson();
    }
    data['productId'] = this.productId;
    if (this.shippingInfo != null) {
      data['shippingInfo'] = this.shippingInfo!.toJson();
    }
    data['total'] = this.total;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['color'] = this.color;
    data['quantity'] = this.quantity;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    return data;
  }
}
