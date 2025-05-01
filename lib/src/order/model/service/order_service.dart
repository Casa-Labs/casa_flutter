import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/src/order/model/create_order.dart';
import 'package:casaflutterapp/src/order/model/create_order_response.dart';
import 'package:casaflutterapp/src/order/model/verify_payment_response_model.dart';

class OrderService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<CreateOrderResponse?> createOrder({
    required CreateOrder createOrderRequestModel,
  }) async {
    final CreateOrderResponse createOrderResponse;

    final response = await _graphQLManager.createOrder(
      createOrderRequestModel.userId ?? "",
      createOrderRequestModel.totalAmount ?? 0,
      createOrderRequestModel.deliveryType ?? "",
      createOrderRequestModel.discountCode ?? "",
      createOrderRequestModel.deliveryInstructions ?? "",
      createOrderRequestModel.items ?? [],
      createOrderRequestModel.paymentInfo ?? PaymentInfo(),
      createOrderRequestModel.shippingInfo ?? ShippingInfo(),
    );

    createOrderResponse = CreateOrderResponse.fromJson(response.data);

    return createOrderResponse;
  }

  Future<VerifyPaymentResponseModel?> verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    final VerifyPaymentResponseModel verifyPaymentResponseModel;

    final response = await _graphQLManager.verifyPayment(
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );

    verifyPaymentResponseModel = VerifyPaymentResponseModel.fromJson(
      response.data,
    );

    if (response.exception != null) {
      return VerifyPaymentResponseModel(
        errorMessage: response.exception?.graphqlErrors.first.message,
      );
    } else {
      return verifyPaymentResponseModel;
    }
  }
}
