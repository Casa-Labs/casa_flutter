class GetCustomerOrdersResponseModel {
  List<CustomerOrders>? customerOrders;

  GetCustomerOrdersResponseModel({this.customerOrders});

  GetCustomerOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['customerOrders'] != null) {
      customerOrders = <CustomerOrders>[];
      json['customerOrders'].forEach((v) {
        customerOrders!.add(new CustomerOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerOrders != null) {
      data['customerOrders'] =
          this.customerOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerOrders {
  List<Items>? items;
  String? id;
  int? totalAmount;
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
        items!.add(new Items.fromJson(v));
      });
    }
    id = json['id'];
    totalAmount = json['totalAmount'];
    createdAt = json['createdAt'];
    shippingInfo = json['shippingInfo'] != null
        ? new ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    paymentInfo = json['paymentInfo'] != null
        ? new PaymentInfo.fromJson(json['paymentInfo'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['totalAmount'] = this.totalAmount;
    data['createdAt'] = this.createdAt;
    if (this.shippingInfo != null) {
      data['shippingInfo'] = this.shippingInfo!.toJson();
    }
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Items {
  String? id;
  int? price;
  String? productId;
  int? quantity;
  int? total;
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
    price = json['price'];
    productId = json['productId'];
    quantity = json['quantity'];
    total = json['total'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? mainImage;
  String? name;
  String? store;

  Product({this.mainImage, this.name, this.store});

  Product.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    name = json['name'];
    store = json['store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mainImage'] = this.mainImage;
    data['name'] = this.name;
    data['store'] = this.store;
    return data;
  }
}

class ShippingInfo {
  String? city;
  String? name;
  String? address;
  int? pincode;

  ShippingInfo({this.city, this.name, this.address, this.pincode});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    name = json['name'];
    address = json['address'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['name'] = this.name;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['paid_amount'] = this.paidAmount;
    data['payment_date'] = this.paymentDate;
    data['service_provider'] = this.serviceProvider;
    return data;
  }
}