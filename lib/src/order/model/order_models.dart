import 'package:casaflutterapp/src/order/model/create_order.dart';

class OrderModel {
  String? id;
  String? orderDate;
  String? status;
  String? orderNumber;
  int? orderTotal;
  String? invoiceUrl;
  ShippingAddress? shippingAddress;
  List<OrderedItems>? orderedItems;
  PaymentInfo? paymentInfo;
  OrderSummary? orderSummary;

  OrderModel(
      {this.id,
        this.orderDate,
        this.status,
        this.orderNumber,
        this.orderTotal,
        this.invoiceUrl,
        this.shippingAddress,
        this.orderedItems,
        this.paymentInfo,
        this.orderSummary});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDate = json['orderDate'];
    status = json['status'];
    orderNumber = json['orderNumber'];
    orderTotal = json['orderTotal'];
    invoiceUrl = json['invoiceUrl'];
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    if (json['orderedItems'] != null) {
      orderedItems = <OrderedItems>[];
      json['orderedItems'].forEach((v) {
        orderedItems!.add(OrderedItems.fromJson(v));
      });
    }
    paymentInfo = json['paymentInfo'] != null
        ? PaymentInfo.fromJson(json['paymentInfo'])
        : null;
    orderSummary = json['orderSummary'] != null
        ? OrderSummary.fromJson(json['orderSummary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderDate'] = orderDate;
    data['status'] = status;
    data['orderNumber'] = orderNumber;
    data['orderTotal'] = orderTotal;
    data['invoiceUrl'] = invoiceUrl;
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    if (orderedItems != null) {
      data['orderedItems'] = orderedItems!.map((v) => v.toJson()).toList();
    }
    if (paymentInfo != null) {
      data['paymentInfo'] = paymentInfo!.toJson();
    }
    if (orderSummary != null) {
      data['orderSummary'] = orderSummary!.toJson();
    }
    return data;
  }
}

class ShippingAddress {
  String? city;
  String? name;
  int? pincode;

  ShippingAddress({this.city, this.name, this.pincode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    name = json['name'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['name'] = name;
    data['pincode'] = pincode;
    return data;
  }
}

class OrderedItems {
  String? itemName;
  String? brandName;
  String? image;
  int? quantity;
  int? price;

  OrderedItems(
      {this.itemName, this.brandName, this.image, this.quantity, this.price});

  OrderedItems.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    brandName = json['brandName'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemName'] = itemName;
    data['brandName'] = brandName;
    data['image'] = image;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class OrderSummary {
  int? itemsPrice;
  int? postage;
  int? tax;
  int? totalBeforeTax;
  int? orderTotal;

  OrderSummary(
      {this.itemsPrice,
        this.postage,
        this.tax,
        this.totalBeforeTax,
        this.orderTotal});

  OrderSummary.fromJson(Map<String, dynamic> json) {
    itemsPrice = json['itemsPrice'];
    postage = json['postage'];
    tax = json['tax'];
    totalBeforeTax = json['totalBeforeTax'];
    orderTotal = json['orderTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemsPrice'] = itemsPrice;
    data['postage'] = postage;
    data['tax'] = tax;
    data['totalBeforeTax'] = totalBeforeTax;
    data['orderTotal'] = orderTotal;
    return data;
  }
}
