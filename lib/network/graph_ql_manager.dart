// graphql_manager.dart

import 'package:casa_flutter/network/graph_ql_mutations.dart';
import 'package:casa_flutter/network/graph_ql_queries.dart';
import 'package:casa_flutter/network/graph_ql_variables.dart';
import 'package:casa_flutter/network/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLManager {
  final GraphQLClientService _clientService = GraphQLClientService();

  Future<QueryResult> registerUser(String email, String password) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.registerMutation,
      variables: GraphQLVariables.registerVariables(email, password),
    );
  }

  Future<QueryResult> loginUser(String email, String password) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.loginMutation,
      variables: GraphQLVariables.loginVariables(email, password),
    );
  }

  Future<QueryResult> singleSignOn(
      String email, String provider, String providerId) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.singleSignOnMutation,
      variables:
          GraphQLVariables.singleSignOnVariables(email, provider, providerId),
    );
  }

  Future<QueryResult> addItemToCart(
      String userId, Map<String, dynamic> items) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.addItemToCart,
      variables: GraphQLVariables.addItemToCartVariables(userId, items),
    );
  }

  Future<QueryResult> createOrder(
      String productId,
      double total,
      String userId,
      Map<String, dynamic> orderedProductDetails,
      Map<String, dynamic> shippingInfo) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.createOrder,
      variables: GraphQLVariables.createOrderVariables(
          productId, total, userId, orderedProductDetails, shippingInfo),
    );
  }

  Future<QueryResult> createProduct(Map<String, dynamic> input) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.createProduct,
      variables: GraphQLVariables.createProductVariables(input),
    );
  }

  Future<QueryResult> createStore(String userId, String name,
      String description, String type, String logo) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.createStore,
      variables: GraphQLVariables.createStoreVariables(
          userId, name, description, type, logo),
    );
  }

  Future<QueryResult> registerOrderReturn(String userId, String orderId,
      String reason, String replacementId) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.registerOrderReturn,
      variables: GraphQLVariables.registerOrderReturnVariables(
          userId, orderId, reason, replacementId),
    );
  }

  Future<QueryResult> registerProductReview(
      String productId,
      String userId,
      bool liked,
      bool disliked,
      bool viewed,
      int rating,
      String comment) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.registerProductReview,
      variables: GraphQLVariables.registerProductReviewVariables(
          productId, userId, liked, disliked, viewed, rating, comment),
    );
  }

  Future<QueryResult> removeItemFromCart(
      String userId, String productId) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.removeItemFromCart,
      variables:
          GraphQLVariables.removeItemFromCartVariables(userId, productId),
    );
  }

  Future<QueryResult> updateCartItem(
      String userId, String productId, int quantity) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.updateCartItem,
      variables:
          GraphQLVariables.updateCartItemVariables(userId, productId, quantity),
    );
  }

  Future<QueryResult> updateOrder(
      String userId,
      String orderId,
      Map<String, dynamic> orderedProductDetails,
      double total,
      Map<String, dynamic> shippingInfo) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.updateOrder,
      variables: GraphQLVariables.updateOrderVariables(
          userId, orderId, orderedProductDetails, total, shippingInfo),
    );
  }

  Future<QueryResult> updateOrderReturnStatus(
      String returnId, String status, String replacementId) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.updateOrderReturnStatus,
      variables: GraphQLVariables.updateOrderReturnStatusVariables(
          returnId, status, replacementId),
    );
  }

  Future<QueryResult> getNewArrivalProducts(
      int page, int limit, String? search) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getNewArrivalProducts,
      variables:
          GraphQLVariables.getNewArrivalProductsVariables(page, limit, search),
    );
  }

  Future<QueryResult> getOrderReturns(String userId, String orderId) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getOrderReturns,
      variables: GraphQLVariables.getOrderReturnsVariables(userId, orderId),
    );
  }

  Future<QueryResult> getOrders(String userId) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getOrders,
      variables: GraphQLVariables.getOrdersVariables(userId),
    );
  }

  Future<QueryResult> getProductReviews(String productId) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getProductReviews,
      variables: GraphQLVariables.getProductReviewsVariables(productId),
    );
  }

  Future<QueryResult> getProducts(Map<String, dynamic> params) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getProducts,
      variables: GraphQLVariables.getProductsVariables(params),
    );
  }

  Future<QueryResult> getTrendingProducts(
      int page, int limit, String? search) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getTrendingProducts,
      variables:
          GraphQLVariables.getTrendingProductsVariables(page, limit, search),
    );
  }

  Future<QueryResult> getUser(String getUserId) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getUser,
      variables: GraphQLVariables.getUserVariables(getUserId),
    );
  }

  Future<QueryResult> getUsers(int page, int limit, String? search) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getUsers,
      variables: GraphQLVariables.getUsersVariables(page, limit, search),
    );
  }
}
