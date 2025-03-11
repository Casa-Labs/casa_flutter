
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
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    if (json['orderedItems'] != null) {
      orderedItems = <OrderedItems>[];
      json['orderedItems'].forEach((v) {
        orderedItems!.add(new OrderedItems.fromJson(v));
      });
    }
    paymentInfo = json['paymentInfo'] != null
        ? new PaymentInfo.fromJson(json['paymentInfo'])
        : null;
    orderSummary = json['orderSummary'] != null
        ? new OrderSummary.fromJson(json['orderSummary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderDate'] = this.orderDate;
    data['status'] = this.status;
    data['orderNumber'] = this.orderNumber;
    data['orderTotal'] = this.orderTotal;
    data['invoiceUrl'] = this.invoiceUrl;
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    if (this.orderedItems != null) {
      data['orderedItems'] = this.orderedItems!.map((v) => v.toJson()).toList();
    }
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo!.toJson();
    }
    if (this.orderSummary != null) {
      data['orderSummary'] = this.orderSummary!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['name'] = this.name;
    data['pincode'] = this.pincode;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['brandName'] = this.brandName;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}

class PaymentInfo {
  String? method;
  int? totalPaid;
  String? transactionId;

  PaymentInfo({this.method, this.totalPaid, this.transactionId});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    totalPaid = json['totalPaid'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['totalPaid'] = this.totalPaid;
    data['transactionId'] = this.transactionId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemsPrice'] = this.itemsPrice;
    data['postage'] = this.postage;
    data['tax'] = this.tax;
    data['totalBeforeTax'] = this.totalBeforeTax;
    data['orderTotal'] = this.orderTotal;
    return data;
  }
}
