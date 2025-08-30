import 'package:casaflutter/network/graph_ql_manager.dart';
import 'package:casaflutter/src/order/model/create_order.dart';
import 'package:casaflutter/src/order/model/create_order_response.dart';
import 'package:casaflutter/src/order/model/verify_payment_response_model.dart';

class OrderService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<CreateOrderResponse?> createOrder({
    required CreateOrderRequest createOrderRequestModel,
  }) async {
    final CreateOrderResponse createOrderResponse;

    final input = createOrderRequestModel.input;

    final response = await _graphQLManager.createOrder(
      input?.userId ?? "",
      input?.totalAmount ?? 0,
      input?.deliveryType ?? "",
      input?.discountCode ?? "",
      input?.deliveryInstructions ?? "",
      input?.items ?? [],
      input?.paymentInfo ?? PaymentInfo(),
      input?.shippingInfo ?? ShippingInfo(),
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
