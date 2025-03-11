class GraphQLQueries {
  static const String getNewArrivalProducts = """
query GetNewArrivalProducts(\$page: Int!, \$limit: Int!, \$search: String) {
  getNewArrivalProducts(page: \$page, limit: \$limit, search: \$search) {
    products {
    price
      category
      createdAt
      description
      id
      isNewArrival
      isTrending
      name
      size
      stock
      storeId
      updatedAt
    }
  }
}
""";

  static const String getNewArrivalProductsForExplore = """
query GetNewArrivalProducts(\$page: Int!, \$limit: Int!) {
  getNewArrivalProducts(page: \$page, limit: \$limit) {
      totalCount
    products {
      mainImage
      id
      name
      price
      description
    }
  }
}
""";

  static const String getCategory = """
query GetProductCategories {
  getProductCategories {
    name
    thumbnail
    id
  }
}
""";

  static const String getNotification = """
query NotificationByUser(\$userId: String!) {
  notificationByUser(userId: \$userId) {
    id
    title
    message
    firstImage
    secondImage
    isRead
    createdAt
  }
}
""";

  static const String getSizes = """
query GetProductSizes {
  getProductSizes {
    name
    id
  }
}
""";

  static const String getBrand = """
query GetBrands(\$storeType: StoreType!, \$page: Int, \$limit: Int, \$search: String) {
  getBrands(storeType: \$storeType, page: \$page, limit: \$limit, search: \$search) {
    data {
      type
      description
      id
      isDeleted
      logo
      name
      createdAt
    }
    total
    totalPages
    currentPage
  }
}
""";

  static const String getOrderReturns = """
query GetOrderReturns(\$userId: String!, \$orderId: String!) {
  getOrderReturns(userId: \$userId, orderId: \$orderId) {
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
""";

  static const String getOrders = """
query GetOrders(\$userId: String!) {
  myOrders(userId: \$userId) {
    id
    orderDate
    status
    orderNumber
    orderTotal
    invoiceUrl
    shippingAddress {
      city
      name
      pincode
    }
    orderedItems {
      itemName
      brandName
      image
      quantity
      price
    }
    paymentInfo {
      method
      totalPaid
      transactionId
    }
    orderSummary {
      itemsPrice
      postage
      tax
      totalBeforeTax
      orderTotal
    }
  }
}
""";

  static const String getProductReviews = """
query GetProductReviews(\$productId: String!) {
  getProductReviews(productId: \$productId) {
    comment
    createdAt
    disliked
    liked
    productId
    rating
    userId
    updatedAt
    viewed
  }
}
""";

  static const String getProducts = """
query GetProducts(\$params: GetProduct!) {
  getProducts(params: \$params) {
       data {
      productImages
      mainImage
      name
      price
      sizes {
        productId
        sizeId
        size {
          id
          name
          createdAt
          updatedAt
        }
      }
      description
      customReturnPolicy
      customShippingPolicy
      categoryId
      id
    }
    total
    currentPage
    totalPages
  }
}
""";

//   static const String getTrendingProducts = """
// query GetTrendingProducts(\$page: Int!, \$limit: Int!, \$search: String) {
//   getTrendingProducts(page: \$page, limit: \$limit, search: \$search) {
//     products {
//       category
//       createdAt
//       description
//       id
//       isNewArrival
//       isTrending
//       name
//       price
//       size
//       stock
//       storeId
//       updatedAt
//     }
//     totalCount
//   }
// }
// """;

  static const String getTrendingProducts = """
query GetTrendingProducts(\$page: Int!, \$limit: Int!) {
  getTrendingProducts(page: \$page, limit: \$limit) {
    totalCount
    products {
      name
      price
      productImages
    }
  }
}
""";

  static const String getUser = """
query GetUser(\$getUserId: String!) {
  getUser(id: \$getUserId) {
    authProvider
    createdAt
    email
    id
    role
    updatedAt
  }
}
""";

  static const String getUsers = """
query GetUsers(\$page: Int!, \$limit: Int!, \$search: String) {
  getUsers(page: \$page, limit: \$limit, search: \$search) {
    currentPage
    data {
      authProvider
      createdAt
      email
      id
      role
      updatedAt
    }
    total
    totalPages
  }
}
""";

  static const String getCartItems = """
query GetCartItems(\$userId: String!) {
  getCartItems(userId: \$userId) {
    createdAt
    id
    item
    updatedAt
    userId
  }
}
""";
}
