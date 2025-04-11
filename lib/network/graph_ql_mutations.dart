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
        name
        phone
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
      name
      phone
      role
      updatedAt
    }
  }
}
""";

  static const String deleteUser = """
  mutation DeleteUser(\$userId: ID!) {
  deleteUser(userId: \$userId)
}
""";

  static const String updateUserDetails = """
  mutation UpdateUserDetails(\$userId: String!, \$name: String, \$email: String, \$phone: String) {
  updateUserDetails(userId: \$userId, name: \$name, email: \$email, phone: \$phone) {
    id
    profileImage
    name
    email
    phone
  }
}
""";

  static const String addStylePreferences = """
  mutation AddPreferences(\$userId: String!, \$styles: [String]) {
  addPreferences(userId: \$userId, styles: \$styles) {
    id
    userId
  }
}
""";

  static const String addBodyTypePreferences = """
  mutation AddPreferences(\$userId: String!, \$bodyTypes: [String]) {
  addPreferences(userId: \$userId, bodyTypes: \$bodyTypes) {
    id
    userId
  }
}
""";

  static const String addFitPreferences = """
  mutation AddPreferences(\$userId: String!, \$fitPrefrence: [String]) {
  addPreferences(userId: \$userId, fitPrefrence: \$fitPrefrence) {
    id
    userId
  }
}
""";

  static const String addUserAddress = """
  mutation AddUserAddress(\$userId: String!, \$address: String!, \$city: String!, \$state: String!, \$pincode: String!,\$landmark: String, \$country: String!) {
  addUserAddress(userId: \$userId, address: \$address, city: \$city, state: \$state, pincode: \$pincode,landmark: \$landmark, country: \$country) {
    id
    userId
    address
    landmark
    city
    state
    pincode
    country
  }
}
""";

  static const String singleSignOnMutation = """
  mutation SingleSignOn(\$email: String!, \$provider: AuthProvider!, \$providerId: String!, \$name: String!, \$image: String!) {
  SingleSignOn(email: \$email, provider: \$provider, providerId: \$providerId, name: \$name, image: \$image) {
   token
    user {
      email
      id
      isRegistered
      isVerified
      name
      image
    }
  }
}
""";

  static const String verifyEmailOtpForRegistration = """
  mutation VerifyOTPAndSendWelcomeEmail(\$email: String!, \$otp: String!) {
  verifyOTPAndSendWelcomeEmail(email: \$email, otp: \$otp) {
    isVerified
    isRegistered
    isDeleted
    id
    email
    createdAt
    authProvider
    name
    phone
    profileImage
    role
  }
}
  """;

  static const String requestPasswordReset = """
  mutation RequestPasswordReset(\$email: String!) {
  requestPasswordReset(email: \$email)
}
  """;

  static const String verifyOTPAndUpdatePassword = """
  mutation VerifyOTPAndUpdatePassword(\$email: String!, \$otp: String!, \$newPassword: String!) {
  verifyOTPAndUpdatePassword(email: \$email, otp: \$otp, newPassword: \$newPassword)
}
  """;

  static const String addItemToCart = '''
mutation AddItemToCart(\$item: JSON!, \$userId: String) {
  addItemToCart(item: \$item, userId: \$userId) {
    id
    userId
    item
    createdAt
    updatedAt
  }
}
''';

  static const String createOrder = '''
mutation CreateOrder(\$totalAmount: Float!, \$deliveryType: String!, \$shippingInfo: JSON!, \$items: [JSON!]!, \$userId: ID!, \$paymentInfo: JSON, \$deliveryInstructions: String, \$discountCode: String) {
  createOrder(totalAmount: \$totalAmount, deliveryType: \$deliveryType, shippingInfo: \$shippingInfo, items: \$items, userId: \$userId, paymentInfo: \$paymentInfo, deliveryInstructions: \$deliveryInstructions, discountCode: \$discountCode) {
    id
    userId
    status
    shippingInfo
    paymentInfo
    totalAmount
    discountCode
    deliveryType
    deliveryInstructions
    items {
      id
      productId
      product {
        name
        price
        isNewArrival
        isTrending
        isDeleted
        gender
        stock
        createdAt
        description
        customReturnPolicy
        customShippingPolicy
        id
        mainImage
        productImages
        storeId
      }
      quantity
      price
      total
    }
    createdAt
    updatedAt
    paymentOrderDetails {
      id
      amount
      currency
      status
      orderId
      paymentId
      createdAt
      updatedAt
      razorpayOrderId
      userId
    }
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
mutation RemoveItemFromCart(\$userId: String!, \$removeItemFromCartId: String!) {
  removeItemFromCart(userId: \$userId, id: \$removeItemFromCartId) {
    id
    userId
    item
    createdAt
    updatedAt
  }
}
''';

  static const String updateCartItem = '''
mutation UpdateCartItem(\$userId: String, \$productId: String, \$quantity: Int) {
  updateCartItem(userId: \$userId, productId: \$productId, quantity: \$quantity) {
    createdAt
    id
    item
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

  static const String createCloset = '''
mutation CreateCloset(\$name: String!) {
  createCloset(name: \$name) {
    createdAt
    id
    name
    user {
      id
      name
    }
  }
}
''';

  static const String addItemToCloset = '''
mutation AddItemToCloset(\$closetId: ID!, \$name: String!, \$imageUrl: String!) {
  addItemToCloset(closetId: \$closetId, name: \$name, imageUrl: \$imageUrl) {
    id
    createdAt
    closet {
      id
      name
    }
    imageUrl
    name
  }
}
''';

  static const String saveItemToCloset = '''
mutation SaveItem(\$clothingItemId: ID!, \$productId: ID!) {
  saveItem(clothingItemId: \$clothingItemId, productId: \$productId) {
    clothingItem {
      name
      imageUrl
      id
      createdAt
    }
    user {
      name
      id
    }
    id
    createdAt
    product {
      mainImage
      gender
      id
      name
      description
      price
      productImages
    }
  }
}
''';

  static const String removeItemFromCloset = '''
mutation RemoveItemFromCloset(\$itemId: ID!) {
  removeItemFromCloset(itemId: \$itemId)
}
''';

  static const String removeItemFromClothingItem = '''
mutation RemoveItemFromClothingItem(\$itemId: ID!) {
  removeItemFromClothingItem(itemId: \$itemId)
}
''';

  static const String verifyPayment = '''
mutation VerifyPayment(\$paymentId: String!, \$orderId: String!, \$signature: String!) {
  verifyPayment(paymentId: \$paymentId, orderId: \$orderId, signature: \$signature) {
    success
    message
    data {
      id
      amount
      currency
      status
      orderId
      paymentId
      createdAt
      updatedAt
    }
  }
}
''';

  static const String deleteAllNotificationsForUser = '''
mutation DeleteAllNotificationsForUser(\$userId: String!) {
  deleteAllNotificationsForUser(userId: \$userId)
}
''';

  static const String deleteNotificationForUser = '''
mutation DeleteNotificationForUser(\$id: String!) {
  deleteNotificationForUser(id: \$id)
}
''';
}
