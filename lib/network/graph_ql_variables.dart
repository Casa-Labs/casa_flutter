class GraphQLVariables {
  //MUTATION
  static Map<String, dynamic> loginVariables(String email, String password) {
    return {
      "email": email,
      "password": password,
    };
  }

  static Map<String, dynamic> registerVariables(String email, String password) {
    return {
      "email": email,
      "password": password,
    };
  }

  static Map<String, dynamic> getBrandVariables(
      String? storeType, int? page, int? limit, String? search) {
    return {
      "storeType": storeType,
      "page": page,
      "limit": limit,
      "search": search,
    };
  }

  static Map<String, dynamic> deleteUserVariables(String userId) {
    return {
      "userId": userId,
    };
  }

  static Map<String, dynamic> updateUserDetailsVariables(
    String userId,
    String name,
    String email,
    String phone,
  ) {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "phone": phone,
    };
  }

  static Map<String, dynamic> addStylePreferencesVariables(
    String userId,
    List<String> styles,
  ) {
    return {
      "userId": userId,
      "styles": styles,
    };
  }

  static Map<String, dynamic> addBodyTypePreferencesVariables(
    String userId,
    List<String> bodyTypes,
  ) {
    return {
      "userId": userId,
      "bodyTypes": bodyTypes,
    };
  }

  static Map<String, dynamic> addFitPreferencesVariables(
    String userId,
    List<String> fitPreferences,
  ) {
    return {
      "userId": userId,
      "fitPrefrence": fitPreferences,
    };
  }

  static Map<String, dynamic> addUserAddressVariables(
    String userId,
    String address,
    String city,
    String state,
    String pinCode,
    String country,
  ) {
    return {
      "userId": userId,
      "address": address,
      "city": city,
      "state": state,
      "pincode": pinCode,
      "country": country,
    };
  }

  static Map<String, dynamic> singleSignOnVariables(
      String email, String provider, String providerId) {
    return {
      "email": email,
      "provider": provider,
      "providerId": providerId,
    };
  }

  static Map<String, dynamic> addItemToCartVariables(
      String userId, List<Map<String, dynamic>> items) {
    return {
      "userId": userId,
      "items": items,
    };
  }

  static Map<String, dynamic> createOrderVariables(
      String productId,
      double total,
      String userId,
      Map<String, dynamic> orderedProductDetails,
      Map<String, dynamic> shippingInfo) {
    return {
      "productId": productId,
      "total": total,
      "userId": userId,
      "orderedProductDetails": orderedProductDetails,
      "shippingInfo": shippingInfo,
    };
  }

  static Map<String, dynamic> createProductVariables(
      Map<String, dynamic> input) {
    return {
      "input": input,
    };
  }

  static Map<String, dynamic> createStoreVariables(String userId, String name,
      String description, String type, String logo) {
    return {
      "userId": userId,
      "name": name,
      "description": description,
      "type": type,
      "logo": logo,
    };
  }

  static Map<String, dynamic> registerOrderReturnVariables(
      String userId, String orderId, String reason, String replacementId) {
    return {
      "userId": userId,
      "orderId": orderId,
      "reason": reason,
      "replacementId": replacementId,
    };
  }

  static Map<String, dynamic> registerProductReviewVariables(
      String productId,
      String userId,
      bool liked,
      bool disliked,
      bool viewed,
      int rating,
      String comment) {
    return {
      "productId": productId,
      "userId": userId,
      "liked": liked,
      "disliked": disliked,
      "viewed": viewed,
      "rating": rating,
      "comment": comment,
    };
  }

  static Map<String, dynamic> removeItemFromCartVariables(
      String userId, String productId) {
    return {
      "userId": userId,
      "productId": productId,
    };
  }

  static Map<String, dynamic> updateCartItemVariables(
      String userId, String productId, int quantity) {
    return {
      "userId": userId,
      "productId": productId,
      "quantity": quantity,
    };
  }

  static Map<String, dynamic> updateOrderVariables(
      String userId,
      String orderId,
      Map<String, dynamic> orderedProductDetails,
      double total,
      Map<String, dynamic> shippingInfo) {
    return {
      "userId": userId,
      "orderId": orderId,
      "orderedProductDetails": orderedProductDetails,
      "total": total,
      "shippingInfo": shippingInfo,
    };
  }

  static Map<String, dynamic> updateOrderReturnStatusVariables(
      String returnId, String status, String replacementId) {
    return {
      "returnId": returnId,
      "status": status,
      "replacementId": replacementId,
    };
  }

  //QUERIES

  static Map<String, dynamic> getNewArrivalProductsVariables(
      int page, int limit, String? search) {
    return {
      "page": page,
      "limit": limit,
      "search": search,
    };
  }

  static Map<String, dynamic> getOrderReturnsVariables(
      String userId, String orderId) {
    return {
      "userId": userId,
      "orderId": orderId,
    };
  }

  static Map<String, dynamic> getOrdersVariables(String userId) {
    return {
      "userId": userId,
    };
  }

  static Map<String, dynamic> getProductReviewsVariables(String productId) {
    return {
      "productId": productId,
    };
  }

  static Map<String, dynamic> getProductsVariables(
      Map<String, dynamic> params) {
    return {
      "params": params,
    };
  }

  static Map<String, dynamic> getTrendingProductsVariables(
      int page, int limit, String? search) {
    return {
      "page": page,
      "limit": limit,
      "search": search,
    };
  }

  static Map<String, dynamic> getUserVariables(String getUserId) {
    return {
      "getUserId": getUserId,
    };
  }

  static Map<String, dynamic> getUsersVariables(
      int page, int limit, String? search) {
    return {
      "page": page,
      "limit": limit,
      "search": search,
    };
  }

  static Map<String, dynamic> getCartItemsVariables(String userId) {
    return {
      "userId": userId,
    };
  }
}
