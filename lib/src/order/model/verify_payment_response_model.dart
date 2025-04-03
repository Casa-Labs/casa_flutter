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
  String? data;

  VerifyPayment({
    this.success,
    this.message,
    this.data,
  });

  VerifyPayment.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
