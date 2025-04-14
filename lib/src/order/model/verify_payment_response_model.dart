import 'package:casaflutterapp/utils/base_model.dart';

class VerifyPaymentResponseModel extends BaseModel {
  VerifyPayment? verifyPayment;

  VerifyPaymentResponseModel({
    this.verifyPayment,
    super.errorMessage,
  });

  VerifyPaymentResponseModel.fromJson(Map<String, dynamic>? json) {
    verifyPayment = json?['verifyPayment'] != null
        ? VerifyPayment.fromJson(json?['verifyPayment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (verifyPayment != null) {
      data['verifyPayment'] = verifyPayment!.toJson();
    }
    return data;
  }
}

class VerifyPayment {
  bool? success;
  String? message;
  Data? data;

  VerifyPayment({
    this.success,
    this.message,
    this.data,
  });

  VerifyPayment.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  double? amount;
  String? currency;
  String? status;
  String? orderId;
  String? paymentId;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.amount,
    this.currency,
    this.status,
    this.orderId,
    this.paymentId,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'] is int
        ? (json['amount'] as int).toDouble()
        : (json['amount'] ?? 0).toDouble();
    currency = json['currency'];
    status = json['status'];
    orderId = json['orderId'];
    paymentId = json['paymentId'];
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
