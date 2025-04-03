import 'dart:convert';
import 'package:casaflutterapp/src/auth/model/auth_models.dart';
import 'package:casaflutterapp/src/common/payment/razorpay_consts.dart';
import 'package:casaflutterapp/utils/preference_manager.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Usage
// Payment.of(
//       50000, // Amount
//       orderId: 'order_Kdts7cugCiRemw', // Order ID of Razorpay
//       handlePaymentSuccess: () {}, // Success Handler
//       handlePaymentError: () {}, // Error Handler
//       handleExternalWallet: () {}, // External wallet Handler
//     );

typedef PaymentSuccessCallback = Function(PaymentSuccessResponse? response);
typedef PaymentErrorCallback = Function(PaymentFailureResponse? response);
typedef ExternalWalletCallback = Function(ExternalWalletResponse? response);

// ignore: avoid_classes_with_only_static_members
class Payment {
  /// The [amount] should not be in small unit
  /// [orderId] to be generated using a backend API
  static Future<void> of({
    required final int amount,
    required final String orderId,
    required final PaymentSuccessCallback handlePaymentSuccess,
    required final PaymentErrorCallback handlePaymentError,
    required final ExternalWalletCallback handleExternalWallet,
  }) async {
    if (amount > 0) {
      final Razorpay razorpay = Razorpay()
        ..on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess)
        ..on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError)
        ..on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

      // get user details
      final userDetailsData = PreferenceManager.getString(
        PreferenceManager.userDetails,
      );
      var userDetailsMap = <String, dynamic>{};
      if (userDetailsData != null) {
        userDetailsMap = json.decode(userDetailsData.trim());
      }
      final userDetails = User.fromJson(userDetailsMap);

      final Map<String, Object> options = <String, Object>{
        'key': RazorpayConst.devKeyId,
        'amount': amount,
        'name': 'Casa',
        'order_id': orderId,
        'description': 'CASA. Where your style journey begins',
        'prefill': <String, dynamic>{
          'contact': userDetails.phone ?? '',
          'email': userDetails.email ?? '',
        },
        'notes': <String, dynamic>{
          'env': 'Test',
        }
      };
      razorpay.open(options);
    }
  }
}
