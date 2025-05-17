class GraphQLMutations {
  static const String registerMutation = """
  mutation Register(\$email: String!, \$password: String!,\$deviceId: String!) {
    register(email: \$email, password: \$password ,deviceId: \$deviceId) {
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
      isRegistered
      isVerified
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
    role
    isRegistered
    isVerified
    isDeleted
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
  mutation AddOrUpdateUserAddress(\$userId: String!, \$address: String!, \$city: String!, \$state: String!, \$pincode: String!, \$country: String!, \$landmark: String, \$tag: String) {
  addUserAddress(userId: \$userId, address: \$address, city: \$city, state: \$state, pincode: \$pincode, country: \$country, landmark: \$landmark, tag: \$tag) {
    id
    userId
    address
    city
    country
    createdAt
    landmark
    pincode
    state
    tag
  }
}
""";

  static const String updateUserAddress = """
  mutation UpdateUserAddress(\$id: String!, \$address: String!, \$city: String!, \$state: String!, \$pincode: String!, \$country: String!, \$landmark: String, \$tag: String) {
  updateUserAddress(id: \$id, address: \$address, city: \$city, state: \$state, pincode: \$pincode, country: \$country, landmark: \$landmark, tag: \$tag) {
    id
    userId
    tag
    address
    landmark
    city
    state
    pincode
    country
    createdAt
    updatedAt
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
      profileImage
    }
  }
}
""";

  static const String verifyRegistrationOTP = """
  mutation VerifyRegistratioOTP(\$email: String!, \$otp: String!) {
  verifyRegistratioOTP(email: \$email, otp: \$otp) 
}
  """;

  static const String requestPasswordReset = """
  mutation RequestPasswordReset(\$email: String!) {
  requestPasswordReset(email: \$email)
}
  """;

  static const String sendRegistrationOTP = """
  mutation SendRegistrationOTP(\$email: String!) {
  sendRegistrationOTP(email: \$email)
}
  """;

  static const String verifyOTPForPasswordUpdate = """
  mutation VerifyOTPForPasswordUpdate(\$email: String!, \$otp: String!) {
  verifyOTPForPasswordUpdate(email: \$email, otp: \$otp)
}
  """;

  static const String updatePasswordAfterVerification = """
  mutation UpdatePasswordAfterVerification(\$email: String!, \$newPassword: String!) {
  updatePasswordAfterVerification(email: \$email, newPassword: \$newPassword)
}
  """;

  static const String updatePasswordWithinApp = """
  mutation UpdatePasswordWithinApp(\$email: String!, \$newPassword: String!) {
  updatePasswordWithinApp(email: \$email, newPassword: \$newPassword)
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

  static const String deleteUserAddress = """
mutation DeleteUserAddress(\$deleteUserAddressId: String!) {
  deleteUserAddress(id: \$deleteUserAddressId)
}
""";
}
