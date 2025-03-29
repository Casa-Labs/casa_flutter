import '../../../../network/graph_ql_manager.dart';
import '../create_order.dart';
import '../create_order_response.dart';

class OrderService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<CreateOrderResponse?> createOrder({
    required CreateOrder createOrderRequestModel,
  }) async {
    final CreateOrderResponse createOrderResponse;

    final response = await _graphQLManager.createOrder(
      createOrderRequestModel.userId ?? "",
      createOrderRequestModel.totalAmount ?? 0.0,
      createOrderRequestModel.deliveryType ?? "",
      createOrderRequestModel.discountCode ?? "",
      createOrderRequestModel.deliveryInstructions ?? "",
      createOrderRequestModel.items ?? [],
      createOrderRequestModel.paymentInfo ?? PaymentInfo(),
      createOrderRequestModel.shippingInfo ?? ShippingInfo(),
    );

    createOrderResponse = CreateOrderResponse.fromJson(
      response.data!,
    );

    return createOrderResponse;
  }

}