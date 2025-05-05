// graphql_manager.dart
import 'package:casaflutterapp/network/graph_ql_mutations.dart';
import 'package:casaflutterapp/network/graph_ql_queries.dart';
import 'package:casaflutterapp/network/graph_ql_variables.dart';
import 'package:casaflutterapp/network/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../src/order/model/create_order.dart';

class GraphQLManager {
  final GraphQLClientService _clientService = GraphQLClientService();

  //MUTATION
  Future<QueryResult> registerUser(String email, String password) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.registerMutation,
      variables: GraphQLVariables.registerVariables(email, password),
    );
  }

  Future<QueryResult> verifyRegistrationOTP({
    required String email,
    required String otp,
  }) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.verifyRegistrationOTP,
      variables: GraphQLVariables.verifyRegistrationOTP(
        email,
        otp,
      ),
    );
  }

  Future<QueryResult> requestPasswordReset({
    required String email,
  }) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.requestPasswordReset,
      variables: GraphQLVariables.requestPasswordReset(
        email,
      ),
    );
  }

  Future<QueryResult> sendRegistrationOTP({
    required String email,
  }) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.sendRegistrationOTP,
      variables: GraphQLVariables.sendRegistrationOTP(
        email,
      ),
    );
  }

  Future<QueryResult> verifyOTPForPasswordUpdate({
    required String email,
    required String otp,
  }) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.verifyOTPForPasswordUpdate,
      variables: GraphQLVariables.verifyOTPForPasswordUpdate(
        email,
        otp,
      ),
    );
  }

  Future<QueryResult> updatePasswordAfterVerification({
    required String email,
    required String newPassword,
  }) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.updatePasswordAfterVerification,
      variables: GraphQLVariables.updatePasswordAfterVerification(
        email,
        newPassword,
      ),
    );
  }

  Future<QueryResult> updatePasswordWithinApp({
    required String email,
    required String newPassword,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.updatePasswordWithinApp,
      variables: GraphQLVariables.updatePasswordWithinApp(
        email,
        newPassword,
      ),
    );
  }

  Future<QueryResult> loginUser(String email, String password) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.loginMutation,
      variables: GraphQLVariables.loginVariables(email, password),
    );
  }

  Future<QueryResult> getNotification(String userID) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getNotification,
      variables: GraphQLVariables.getNotificationVariables(userID),
    );
  }

  Future<QueryResult> deleteUser({required String userId}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.deleteUser,
      variables: GraphQLVariables.deleteUserVariables(userId),
    );
  }

  Future<QueryResult> updateUserDetails({
    required String userId,
    required String name,
    required String email,
    required String phone,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.updateUserDetails,
      variables: GraphQLVariables.updateUserDetailsVariables(
        userId,
        name,
        email,
        phone,
      ),
    );
  }

  Future<QueryResult> addStylePreferences({
    required String userId,
    required List<String> styles,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.addStylePreferences,
      variables: GraphQLVariables.addStylePreferencesVariables(
        userId,
        styles,
      ),
    );
  }

  Future<QueryResult> addBodyTypePreferences({
    required String userId,
    required List<String> bodyTypes,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.addBodyTypePreferences,
      variables: GraphQLVariables.addBodyTypePreferencesVariables(
        userId,
        bodyTypes,
      ),
    );
  }

  Future<QueryResult> addFitPreferences({
    required String userId,
    required List<String> fitPreferences,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.addFitPreferences,
      variables: GraphQLVariables.addFitPreferencesVariables(
        userId,
        fitPreferences,
      ),
    );
  }

  Future<QueryResult> addUserAddress({
    required String userId,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String country,
    String? landmark,
    String? tag,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.addUserAddress,
      variables: GraphQLVariables.addUserAddressVariables(
        userId,
        address,
        city,
        state,
        pinCode,
        country,
        landmark,
        tag,
      ),
    );
  }

  Future<QueryResult> updateUserAddress({
    required String id,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String country,
    String? landmark,
    String? tag,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.updateUserAddress,
      variables: GraphQLVariables.updateUserAddressVariables(
        id,
        address,
        city,
        state,
        pinCode,
        country,
        landmark,
        tag,
      ),
    );
  }

  Future<QueryResult> singleSignOn({
    required String email,
    required String provider,
    required String providerId,
    required String name,
    required String image,
  }) async {
    return await _clientService.performMutationWithoutToken(
      document: GraphQLMutations.singleSignOnMutation,
      variables: GraphQLVariables.singleSignOnVariables(
        email,
        provider,
        providerId,
        name,
        image,
      ),
    );
  }

  Future<QueryResult> addItemToCart(
      {required String userId, required Map<String, dynamic> items}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.addItemToCart,
      variables: GraphQLVariables.addItemToCartVariables(userId, items),
    );
  }

  Future<QueryResult> createOrder(
    String userId,
    int totalAmount,
    String deliveryType,
    String discountCode,
    String deliveryInstructions,
    List<Items> items,
    PaymentInfo paymentInfo,
    ShippingInfo shippingInfo,
  ) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.createOrder,
      variables: GraphQLVariables.createOrderVariables(
        userId,
        totalAmount,
        deliveryType,
        discountCode,
        deliveryInstructions,
        items,
        paymentInfo,
        shippingInfo,
      ),
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
      {required String productId,
      required String userId,
      required bool liked,
      required bool disliked,
      required bool viewed,
      required int rating,
      required String comment}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.registerProductReview,
      variables: GraphQLVariables.registerProductReviewVariables(
          productId, userId, liked, disliked, viewed, rating, comment),
    );
  }

  Future<QueryResult> removeItemFromCart(
      {required String userId, required String removeItemFromCartId}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.removeItemFromCart,
      variables: GraphQLVariables.removeItemFromCartVariables(
          userId, removeItemFromCartId),
    );
  }

  Future<QueryResult> updateCartItem(
      {required String userId,
      required String productId,
      required int quantity}) async {
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

  Future<QueryResult> createCloset({required String name}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.createCloset,
      variables: GraphQLVariables.createCloset(name),
    );
  }

  Future<QueryResult> addItemToCloset(
      {required String closetId,
      required String name,
      required String imageUrl}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.addItemToCloset,
      variables: GraphQLVariables.addItemToCloset(closetId, name, imageUrl),
    );
  }

  Future<QueryResult> saveItemToCloset(
      {required String clothingItemId, required String productId}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.saveItemToCloset,
      variables: GraphQLVariables.saveItemToCloset(clothingItemId, productId),
    );
  }

  Future<QueryResult> removeItemFromCloset({required String itemId}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.removeItemFromCloset,
      variables: GraphQLVariables.removeItemFromCloset(itemId),
    );
  }

  Future<QueryResult> removeItemFromClothingItem(
      {required String itemId}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.removeItemFromClothingItem,
      variables: GraphQLVariables.removeItemFromClothingItem(itemId),
    );
  }

  Future<QueryResult> deleteAllNotificationsForUser(
      {required String userId}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.deleteAllNotificationsForUser,
      variables: GraphQLVariables.deleteAllNotificationsForUser(userId),
    );
  }

  Future<QueryResult> deleteNotificationForUser({required String id}) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.deleteNotificationForUser,
      variables: GraphQLVariables.deleteNotificationForUser(id),
    );
  }

  //QUERIES

  Future<QueryResult> getNewArrivalProducts(
      int page, int limit, String? search) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getNewArrivalProducts,
      variables:
          GraphQLVariables.getNewArrivalProductsVariables(page, limit, search),
    );
  }

  Future<QueryResult> getNewArrivalProductsForExplore(
      int page, int limit, String? search) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getNewArrivalProductsForExplore,
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

  Future<QueryResult> getProductsForExplore(Map<String, dynamic> params) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getProductsForExplore,
      variables: GraphQLVariables.getProductsVariables(params),
    );
  }

  Future<QueryResult> getRelatedProducts(Map<String, dynamic> params) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getProductsForExplore,
      variables: GraphQLVariables.getProductsVariables(params),
    );
  }

  Future<QueryResult> getProductsForSearch(Map<String, dynamic> params) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getProductsForSearch,
      variables: GraphQLVariables.getProductsVariables(params),
    );
  }

  Future<QueryResult> getProductsById(String productId) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getProductDescription,
      variables: GraphQLVariables.getProductById(productId),
    );
  }

  Future<QueryResult> getBrands(
      {int? limit, int? page, String? search, String? storeType}) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getBrand,
      variables:
          GraphQLVariables.getBrandVariables(storeType, page, limit, search),
    );
  }

  Future<QueryResult> getCategory() async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getCategory,
    );
  }

  Future<QueryResult> getSizes() async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getSizes,
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

  Future<QueryResult> getStoreInventoryById(
      {required int page, required int limit, required String storeId}) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getStoreInventory,
      variables: GraphQLVariables.getStoreInventoryVariables(
          page: page, limit: limit, storeId: storeId),
    );
  }

  Future<QueryResult> getUser({
    required String userId,
  }) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getUser,
      variables: GraphQLVariables.getUserVariables(userId),
    );
  }

  Future<QueryResult> deleteUserAddress({
    required String addressId,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.deleteUserAddress,
      variables: GraphQLVariables.deleteUserAddressVariables(
        addressId,
      ),
    );
  }

  Future<QueryResult> getUsers(int page, int limit, String? search) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getUsers,
      variables: GraphQLVariables.getUsersVariables(page, limit, search),
    );
  }

  Future<QueryResult> getCartItems({required String userId}) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getCartItems,
      variables: GraphQLVariables.getCartItemsVariables(userId)
    );
  }

  Future<QueryResult> getUserClosets({required String userId}) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getUserClosets,
      variables: GraphQLVariables.getUserClosets(userId),
    );
  }

  Future<QueryResult> getClosetById({required String getClosetId}) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getClosetById,
      variables: GraphQLVariables.getClosetById(getClosetId),
    );
  }

  Future<QueryResult> getSavedItemsToCloset(
      {required String userId, required String clothingItemId}) async {
    return await _clientService.performQuery(
      document: GraphQLQueries.getSavedItemsToCloset,
      variables: GraphQLVariables.getSavedItemsToCloset(userId, clothingItemId),
    );
  }

  Future<QueryResult> verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    return await _clientService.performMutation(
      document: GraphQLMutations.verifyPayment,
      variables: GraphQLVariables.verifyPayment(
        paymentId,
        orderId,
        signature,
      ),
    );
  }
}
