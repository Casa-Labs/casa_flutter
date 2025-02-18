class GraphQLMutations {
  static const String registerMutation = """
  mutation Register(\$email: String!, \$password: String!) {
    register(email: \$email, password: \$password) {
      token
      user {
        authProvider
        createdAt
        email
        id
        role
        updatedAt
      }
    }
  }
""";

  static const String loginMutation = """
  mutation Login(\$email: String!, \$password: String!) {
  login(email: \$email, password: \$password) {
    token
    user {
      authProvider
      createdAt
      email
      id
      role
      updatedAt
    }
  }
}
""";

  static const String singleSignOnMutation = """
  mutation SingleSignOn(\$email: String!, \$provider: AuthProvider!, \$providerId: String!) {
  SingleSignOn(email: \$email, provider: \$provider, providerId: \$providerId) {
    token
    user {
      authProvider
      createdAt
      email
      id
      role
      updatedAt
    }
  }
}
""";

  static const String addItemToCart = '''
mutation AddItemToCart(\$userId: String, \$items: JSON) {
  addItemToCart(userId: \$userId, items: \$items) {
    createdAt
    id
    items
    updatedAt
    userId
  }
}
''';

  static const String createOrder = '''
mutation CreateOrder(\$productId: String!, \$total: Float!, \$userId: String, \$orderedProductDetails: JSON, \$shippingInfo: JSON) {
  createOrder(productId: \$productId, total: \$total, userId: \$userId, orderedProductDetails: \$orderedProductDetails, shippingInfo: \$shippingInfo) {
    createdAt
    id
    orderedProductDetails
    productId
    shippingInfo
    total
    updatedAt
    userId
  }
}
''';

  static const String createProduct = '''
mutation CreateProduct(\$input: ProductInput!) {
  createProduct(input: \$input) {
    category
    createdAt
    description
    id
    isNewArrival
    isTrending
    name
    price
    size
    stock
    storeId
    updatedAt
  }
}
''';

  static const String createStore = '''
mutation CreateStore(\$userId: String, \$name: String!, \$description: String, \$type: StoreType!, \$logo: String) {
  createStore(userId: \$userId, name: \$name, description: \$description, type: \$type, logo: \$logo) {
    createdAt
    description
    id
    isDeleted
    logo
    name
    reasonToDelete
    type
    updatedAt
  }
}
''';

  static const String registerOrderReturn = '''
mutation RegisterOrderReturn(\$userId: String!, \$orderId: String!, \$reason: String!, \$replacementId: String) {
  registerOrderReturn(userId: \$userId, orderId: \$orderId, reason: \$reason, replacementId: \$replacementId) {
    createdAt
    id
    orderId
    reason
    replacementId
    status
    updatedAt
    userId
  }
}
''';

  static const String registerProductReview = '''
mutation RegisterProductReview(\$productId: String!, \$userId: String, \$liked: Boolean, \$disliked: Boolean, \$viewed: Boolean, \$rating: Int, \$comment: String) {
  registerProductReview(productId: \$productId, userId: \$userId, liked: \$liked, disliked: \$disliked, viewed: \$viewed, rating: \$rating, comment: \$comment) {
    comment
    createdAt
    disliked
    liked
    productId
    rating
    updatedAt
    userId
    viewed
  }
}
''';

  static const String removeItemFromCart = '''
mutation RemoveItemFromCart(\$userId: String!, \$productId: String!) {
  removeItemFromCart(userId: \$userId, productId: \$productId) {
    createdAt
    id
    items
    updatedAt
    userId
  }
}
''';

  static const String updateCartItem = '''
mutation UpdateCartItem(\$userId: String, \$productId: String, \$quantity: Int) {
  updateCartItem(userId: \$userId, productId: \$productId, quantity: \$quantity) {
    createdAt
    id
    items
    updatedAt
    userId
  }
}
''';

  static const String updateOrder = '''
mutation UpdateOrder(\$userId: String, \$orderId: String, \$orderedProductDetails: JSON, \$total: Float, \$shippingInfo: JSON) {
  updateOrder(userId: \$userId, orderId: \$orderId, orderedProductDetails: \$orderedProductDetails, total: \$total, shippingInfo: \$shippingInfo) {
    createdAt
    id
    orderedProductDetails
    productId
    shippingInfo
    total
    updatedAt
    userId
  }
}
''';

  static const String updateOrderReturnStatus = '''
mutation UpdateOrderReturnStatus(\$returnId: String!, \$status: String!, \$replacementId: String) {
  updateOrderReturnStatus(returnId: \$returnId, status: \$status, replacementId: \$replacementId) {
    createdAt
    id
    orderId
    reason
    replacementId
    status
    updatedAt
    userId
  }
}
''';
}
