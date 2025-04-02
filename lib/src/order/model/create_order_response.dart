import 'package:casaflutterapp/src/order/model/create_order.dart';

class CreateOrderResponse {
  CreateOrderData? createOrder;

  CreateOrderResponse({this.createOrder});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    createOrder = json['createOrder'] != null
        ? CreateOrderData.fromJson(json['createOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (createOrder != null) {
      data['createOrder'] = createOrder!.toJson();
    }
    return data;
  }
}

class CreateOrderData {
  String? id;
  String? userId;
  String? status;
  ShippingInfo? shippingInfo;
  dynamic paymentInfo;
  double? totalAmount;
  dynamic discountCode;
  String? deliveryType;
  dynamic deliveryInstructions;
  List<Items>? items;
  dynamic returns;
  String? createdAt;
  String? updatedAt;
  PaymentOrderDetails? paymentOrderDetails;

  CreateOrderData(
      {this.id,
        this.userId,
        this.status,
        this.shippingInfo,
        this.paymentInfo,
        this.totalAmount,
        this.discountCode,
        this.deliveryType,
        this.deliveryInstructions,
        this.items,
        this.returns,
        this.createdAt,
        this.updatedAt,
        this.paymentOrderDetails});

  CreateOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    status = json['status'];
    shippingInfo = json['shippingInfo'] != null
        ? ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    paymentInfo = json['paymentInfo'];
    totalAmount = json['totalAmount'];
    discountCode = json['discountCode'];
    deliveryType = json['deliveryType'];
    deliveryInstructions = json['deliveryInstructions'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    returns = json['returns'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    paymentOrderDetails = json['paymentOrderDetails'] != null
        ? PaymentOrderDetails.fromJson(json['paymentOrderDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['status'] = status;
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    data['paymentInfo'] = paymentInfo;
    data['totalAmount'] = totalAmount;
    data['discountCode'] = discountCode;
    data['deliveryType'] = deliveryType;
    data['deliveryInstructions'] = deliveryInstructions;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['returns'] = returns;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (paymentOrderDetails != null) {
      data['paymentOrderDetails'] = paymentOrderDetails!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;

  Items({this.id});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class PaymentOrderDetails {
  String? id;
  double? amount;
  String? currency;
  String? status;
  String? orderId;
  dynamic paymentId;
  String? userId;
  String? razorpayOrderId;
  String? createdAt;
  String? updatedAt;

  PaymentOrderDetails(
      {this.id,
        this.amount,
        this.currency,
        this.status,
        this.orderId,
        this.paymentId,
        this.userId,
        this.razorpayOrderId,
        this.createdAt,
        this.updatedAt});

  PaymentOrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    orderId = json['orderId'];
    paymentId = json['paymentId'];
    userId = json['userId'];
    razorpayOrderId = json['razorpayOrderId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['currency'] = currency;
    data['status'] = status;
    data['orderId'] = orderId;
    data['paymentId'] = paymentId;
    data['userId'] = userId;
    data['razorpayOrderId'] = razorpayOrderId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
