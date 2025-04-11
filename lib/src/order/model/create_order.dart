class CreateOrder {
  int? totalAmount;
  String? deliveryInstructions;
  String? deliveryType;
  ShippingInfo? shippingInfo;
  List<Items>? items;
  String? userId;
  PaymentInfo? paymentInfo;
  String? discountCode;

  CreateOrder(
      {this.totalAmount,
        this.deliveryInstructions,
        this.deliveryType,
        this.shippingInfo,
        this.items,
        this.userId,
        this.paymentInfo,
        this.discountCode});

  CreateOrder.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    deliveryInstructions = json['deliveryInstructions'];
    deliveryType = json['deliveryType'];
    shippingInfo = json['shippingInfo'] != null
        ? ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    userId = json['userId'];
    paymentInfo = json['paymentInfo'] != null
        ? PaymentInfo.fromJson(json['paymentInfo'])
        : null;
    discountCode = json['discountCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAmount'] = totalAmount;
    data['deliveryInstructions'] = deliveryInstructions;
    data['deliveryType'] = deliveryType;
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['userId'] = userId;
    if (paymentInfo != null) {
      data['paymentInfo'] = paymentInfo!.toJson();
    }
    data['discountCode'] = discountCode;
    return data;
  }
}

class ShippingInfo {
  String? name;
  String? city;
  int? pincode;
  String? address;

  ShippingInfo({this.name, this.city, this.pincode, this.address});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    pincode = json['pincode'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['city'] = city;
    data['pincode'] = pincode;
    data['address'] = address;
    return data;
  }
}

class Items {
  String? productId;
  double? price;
  String? size;
  String? color;
  int? quantity;

  Items({this.productId, this.price, this.size, this.color, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    price = json['price'];
    size = json['size'];
    color = json['color'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['price'] = price;
    data['size'] = size;
    data['color'] = color;
    data['quantity'] = quantity;
    return data;
  }
}

class PaymentInfo {
  String? method;
  String? serviceProvider;
  int? paidAmount;
  String? paymentDate;

  PaymentInfo(
      {this.method, this.serviceProvider, this.paidAmount, this.paymentDate});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    serviceProvider = json['service_provider'];
    paidAmount = json['paid_amount'];
    paymentDate = json['payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['service_provider'] = serviceProvider;
    data['paid_amount'] = paidAmount;
    data['payment_date'] = paymentDate;
    return data;
  }
}
