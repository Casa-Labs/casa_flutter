class GetCustomerOrdersResponseModel {
  List<CustomerOrders>? customerOrders;

  GetCustomerOrdersResponseModel({this.customerOrders});

  GetCustomerOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['customerOrders'] != null) {
      customerOrders = <CustomerOrders>[];
      json['customerOrders'].forEach((v) {
        customerOrders!.add(CustomerOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerOrders != null) {
      data['customerOrders'] = customerOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerOrders {
  List<Items>? items;
  String? id;
  double? totalAmount;
  String? createdAt;
  ShippingInfo? shippingInfo;
  PaymentInfo? paymentInfo;
  String? status;

  CustomerOrders(
      {this.items,
      this.id,
      this.totalAmount,
      this.createdAt,
      this.shippingInfo,
      this.paymentInfo,
      this.status});

  CustomerOrders.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    id = json['id'];
    totalAmount = (json['totalAmount'] is int)
        ? (json['totalAmount'] as int).toDouble()
        : (json['totalAmount'] is double)
            ? json['totalAmount']
            : null;
    createdAt = json['createdAt'];
    shippingInfo = json['shippingInfo'] != null
        ? ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    paymentInfo = json['paymentInfo'] != null
        ? PaymentInfo.fromJson(json['paymentInfo'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['totalAmount'] = totalAmount;
    data['createdAt'] = createdAt;
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    if (paymentInfo != null) {
      data['paymentInfo'] = paymentInfo!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Items {
  String? id;
  double? price;
  String? productId;
  int? quantity;
  double? total;
  Product? product;

  Items(
      {this.id,
      this.price,
      this.productId,
      this.quantity,
      this.total,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : (json['price'] is double)
            ? json['price']
            : null;
    productId = json['productId'];
    quantity = json['quantity'];
    total = (json['total'] is int)
        ? (json['total'] as int).toDouble()
        : (json['total'] is double)
            ? json['total']
            : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['total'] = total;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? mainImage;
  String? name;
  Store? store;

  Product({this.mainImage, this.name, this.store});

  Product.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    name = json['name'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mainImage'] = mainImage;
    data['name'] = name;
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

class ShippingInfo {
  String? city;
  String? name;
  String? address;
  String? pincode;

  ShippingInfo({this.city, this.name, this.address, this.pincode});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    name = json['name'];
    address = json['address'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['name'] = name;
    data['address'] = address;
    data['pincode'] = pincode;
    return data;
  }
}

class PaymentInfo {
  String? method;
  int? paidAmount;
  String? paymentDate;
  String? serviceProvider;

  PaymentInfo(
      {this.method, this.paidAmount, this.paymentDate, this.serviceProvider});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    paidAmount = json['paid_amount'];
    paymentDate = json['payment_date'];
    serviceProvider = json['service_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['paid_amount'] = paidAmount;
    data['payment_date'] = paymentDate;
    data['service_provider'] = serviceProvider;
    return data;
  }
}
